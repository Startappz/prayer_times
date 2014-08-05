# encoding: UTF-8
module PrayerTimes
  # This is main interface class
  class Calculator
    include Setters

    attr_reader :calculation_method, :time_format, :times_names, :time_suffixes, :invalid_time, :iterations_count, :times_offsets

    # Initializer
    # @param [String] calc_method the calculation method to use
    # @param [Hash] opts formatting options
    # @option opts [String] :time_format
    # @option opts [String] :invalid_time
    # @option opts [String] :time_suffixes
    # @option opts [String] :times_names
    # @option opts [String] :times_offsets
    # @option opts [String] :iterations_count this is algorithmic option. Don't set it unless you know what you are doing
    # @see Setters to get an idea about those options
    def initialize(calc_method, opts)
      self.calculation_method = calc_method

      self.time_format = opts[:time_format]

      self.invalid_time = opts[:invalid_time]

      self.time_suffixes = (opts[:time_suffixes])

      self.times_names = (opts[:times_names])

      self.times_offsets = (opts[:times_offsets])

      self.iterations_count = opts[:iterations_count]
    end



    # Gets the prayers times
    # @param [Date] date the date
    # @param [Array] coords of type [long, lat [,alt]]
    # @param [Integer] time_zone the time zone
    # @param [Integer] dst Daylight saving time
    # @return [Hash] times
    def get_times(date, coords, time_zone, dst = nil)
      Calculation.new(self,
                      date,
                      coords,
                      time_zone + (dst.nil? ? 0 : 1))
      .compute
    end

    private

    def const_class
      PrayerTimes
    end

  end
end
