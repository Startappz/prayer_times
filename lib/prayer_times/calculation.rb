# encoding: UTF-8
module PrayerTimes
  # Calculation class used to do the times calculation in given settings
  class Calculation
    extend Forwardable
    include MathHelpers

    SunPosition = Struct.new(:declination, :equation)

    MINUTE = 60
    DEGREES_PER_HOUR = 15.0

    def_delegators :@calculator, :time_suffixes, :time_format, :invalid_time, :iterations_count, :times_offsets

    # Gets the prayers times
    # @param [PrayTime] calculator parent class
    # @param [Date] date the desired date
    #   It accepts an array as well [year, month, day]
    # @param [Array] coords of type [long, lat [,alt]]
    # @param [Integer] time_zone the time zone
    def initialize(calculator, date, coords, time_zone)
      self.calculator = calculator
      self.lat = coords[0]
      self.lng = coords[1]
      self.elv = coords.size > 2 ? coords[2] : 0
      self.time_zone = time_zone
      self.jdate = julian_date(date) - lng / (360.0)
      self.times = {
        imsak: 5, fajr: 5, sunrise: 6, dhuhr: 12, asr: 13,
        sunset: 18, maghrib: 18, isha: 18
      }
    end

    # Compute prayer times
    # @return [Hash] times
    def compute
      # main iterations
      iterations_count.times{compute_prayer_times}

      adjust_times

      tune_times

      modify_formats

      set_names
    end

    private

    attr_accessor :calculator, :time_zone, :lat, :lng, :elv, :jdate, :times

    # get julian date of date object or array
    def julian_date(date)
      date_obj = date.is_a?(Date) ? date : Date.new(date[0], date[1], date[2])
      date_obj.ajd.to_f
    end

    # convert float time to the given format (see time_formats)
    def get_formatted_time(time)
      return invalid_time if time.nan?
      return time if time_format == 'Float'
      time = fix_hour(time + 0.5 / self.class::MINUTE)  # add 0.5 minutes to round
      hours = time.floor
      minutes = ((time - hours) * self.class::MINUTE).floor
      suffix = time_format == '12h' ? time_suffixes[hours < 12 ? :am : :pm ] : ''
      formatted_time =  (time_format == "24h") ?  ("%02d:%02d" % [hours, minutes]) : "%d:%02d" % [((hours + 11) % 12)+1, minutes]
      formatted_time + suffix
    end

    # compute mid-day time
    def mid_day(time)
      eqt = sun_position(jdate + time).equation
      fix_hour(12 - eqt)
    end

    # compute the time at which sun reaches a specific angle below horizon
    def sun_angle_time(angle, time, direction = nil)
      decl = sun_position(jdate + time).declination
      noon = mid_day(time)
      t = 1.0 / self.class::DEGREES_PER_HOUR * darccos((-rsin(angle)- rsin(decl)* rsin(lat))/
          (rcos(decl) * rcos(lat)))
      return noon + (direction == 'ccw' ? -t : t)
    rescue
      return (0/0.0)    
    end

    # compute asr time
    def asr_time(factor, time)
      decl = sun_position(jdate + time).declination
      angle = -darccot(factor + rtan(lat - decl).abs)
      sun_angle_time(angle, time)
    end

    # compute declination angle of sun and equation of time
    # Ref: http://aa.usno.navy.mil/faq/docs/SunApprox.php
    def sun_position(julian_date)
      d = julian_date - 2451545.0
      g = fix_angle(357.529 + 0.98560028 * d)
      q = fix_angle(280.459 + 0.98564736 * d)
      l = fix_angle(q + 1.915* rsin(g) + 0.020* rsin(2*g))

      #r = 1.00014 - 0.01671 * cos(g) - 0.00014 * cos(2*g)
      e = 23.439 - 0.00000036 * d

      ra = darctan2(rcos(e)* rsin(l), rcos(l))/ self.class::DEGREES_PER_HOUR
      equation = q / self.class::DEGREES_PER_HOUR - fix_hour(ra) # equation of time
      declination = darcsin(rsin(e)* rsin(l)) # declination of the Sun

      SunPosition.new(declination,equation)
    end


    # compute prayer times at given julian date
    def compute_prayer_times
      day_portion

      initial_computation
    end

    # make the primary calculations
    def initial_computation
      times.merge!(
        imsak:   sun_angle_time(method_settings[:imsak].to_f, times[:imsak], 'ccw'),
        fajr:    sun_angle_time(method_settings[:fajr].to_f, times[:fajr], 'ccw'),
        sunrise: sun_angle_time(rise_set_angle(elv), times[:sunrise], 'ccw'),
        dhuhr:   mid_day(times[:dhuhr]),
        asr:     asr_time(asr_factor(method_settings[:asr]), times[:asr]),
        sunset:  sun_angle_time(rise_set_angle(elv), times[:sunset]),
        maghrib: sun_angle_time(method_settings[:maghrib].to_f, times[:maghrib]),
        isha:    sun_angle_time(method_settings[:isha].to_f, times[:isha])
      )
    end

    # adjust times in a prayer time array
    def adjust_times

      adjust_time_zones

      if !method_settings[:high_lats].nil?
        adjust_high_lats
      end

      if minute?(method_settings[:imsak])
        times[:imsak] = times[:fajr] - method_settings[:imsak].to_f / self.class::MINUTE
      end

      # need to ask about 'min' settings
      if minute?(method_settings[:maghrib])
        times[:maghrib] = times[:sunset] + method_settings[:maghrib].to_f / self.class::MINUTE
      end

      if minute?(method_settings[:isha])
        times[:isha] = times[:maghrib] + method_settings[:isha].to_f / self.class::MINUTE
      end

      times[:dhuhr] += method_settings[:dhuhr].to_f / self.class::MINUTE

      # add midnight time
      if method_settings[:midnight] == 'Jafari'
        times[:midnight] = times[:sunset] + time_diff(times[:sunset], times[:fajr]) / 2
      else
        times[:midnight] = times[:sunset] + time_diff(times[:sunset], times[:sunrise]) / 2
      end
    end

    # adjust time zones
    def adjust_time_zones
      tz_adjust = time_zone - lng / self.class::DEGREES_PER_HOUR
      times.keys.each{|k| times[k] += tz_adjust}
    end

    # get asr shadow factor
    def asr_factor(asr)
      calc_methods = {'Standard' => 1, 'Hanafi' => 2}
      calc_methods.include?(asr) ? calc_methods[asr] : asr.to_f
    end

    # return sun angle for sunset/sunrise
    def rise_set_angle(elevation = 0)
      0.833 + 0.0347 * Math.sqrt(elevation) # an approximation
    end

    # apply offsets to the times
    def tune_times
      times.each{|k,_| times[k] += (method_offsets[k] + times_offsets[k]).to_f / self.class::MINUTE}
    end

    # convert times to given time format
    def modify_formats
      times.each{|k,_| times[k] = get_formatted_time(times[k])}
    end

    def set_names
      res = {}
      calculator.times_names.each{|k,v| res[v] = times[k]}
      res
    end

    # adjust times for locations in higher latitudes
    def adjust_high_lats
      night_time = time_diff(times[:sunset], times[:sunrise]) # sunset to sunrise
      times[:imsak] = adjust_hl_time(times[:imsak], times[:sunrise], method_settings[:imsak].to_f, night_time, 'ccw')
      times[:fajr]  = adjust_hl_time(times[:fajr], times[:sunrise], method_settings[:fajr].to_f, night_time, 'ccw')
      times[:isha]  = adjust_hl_time(times[:isha], times[:sunset], method_settings[:isha].to_f, night_time)
      times[:maghrib] = adjust_hl_time(times[:maghrib], times[:sunset], method_settings[:maghrib].to_f, night_time)
    end

    # adjust a time for higher latitudes
    def adjust_hl_time(time, base, angle, night, direction = nil)
      portion = night_portion(angle, night)
      diff = direction == 'ccw' ? time_diff(time, base) : time_diff(base, time)
      if time.nan? or (diff > portion)
        time = base + (direction == 'ccw' ? - portion : portion)
      end
      time
    end

    # the night portion used for adjusting times in higher latitudes
    def night_portion(angle, night)
      hl_method = method_settings[:high_lats]
      portion = 1.0 / 2  # midnight
      portion = 1.0 / self.class::MINUTE * angle if hl_method == 'AngleBased'
      portion = 1.0 / 7 if hl_method == 'OneSeventh'
      portion * night
    end

    # convert hours to day portions
    def day_portion
      times.each{|k,v| times[k] = times[k] / 24.0}
    end

    # compute the difference between two times
    def time_diff(time1, time2); fix_hour(time2 - time1); end

    # detect if input contains 'min'
    def minute?(arg); arg.to_s.include? "min"; end

    def fix_hour(hour); fix(hour, 24.0) ; end

    def fix_angle(angle); fix(angle, 360.0) ; end

    def fix(a, mode)
      return a if a.nan?
      a = a - mode * (a / mode).floor
      a < 0 ? a + mode : a
    end

    def method_settings
      @m_settings ||= calculator.calculation_method.settings
    end

    def method_offsets
      @m_offsets ||= calculator.calculation_method.offsets
    end

  end

end
