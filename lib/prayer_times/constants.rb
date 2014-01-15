# encoding: UTF-8
module PrayerTimes
  # General constants. Don't try to change their values.
  # You have flexible general and instance configurations.
  module Constants
    # Used internally in the algorithm. Don't change unless you know
    # What you are doing
    # 0 < iterations_count < 6
    @iterations_count = 1

    # Determines the accepted values for iterations count
    @accepted_iterations_count_range = 1..5

    # Times names to be displayed
    @times_names = {
      imsak:    'Imsak',
      fajr:     'Fajr',
      sunrise:  'Sunrise',
      dhuhr:    'Dhuhr',
      asr:      'Asr',
      sunset:   'Sunset',
      maghrib:  'Maghrib',
      isha:     'Isha',
      midnight: 'Midnight'
    }

    #  The option time_format takes the following values:
    #  '24h':    24-hour format,
    #  '12h':    12-hour format,
    #  '12hNS':  12-hour format with no suffix,
    #  'Float':  floating point number
    @time_format =    '24h'

    # Determines the accepted time format values
    @accepted_time_formats = ['12h','24h','12hNS','Float']

    # Times suffixes names to be displayed
    @time_suffixes=  {:am => 'AM', :pm => 'PM'}

    # What to display when the time is invalid
    @invalid_time=   '-----'

    # Time offsets
    @times_offsets = @times_names.keys.inject({}){ |h,k| h.merge!(k => 0)}

    class << self
      attr_reader :iterations_count, :times_names,
        :time_format, :time_suffixes,:times_offsets,:invalid_time,
        :accepted_iterations_count_range, :accepted_time_formats
    end
  end
end
