module PrayerTimes
  # General setters 
  module Setters
   
    # Sets iterations c
    # @param [Integer] num
    #   0 < num < 6
    def iterations_count=(num)
      @iterations_count = if (Constants.accepted_iterations_count_range).include?(num)
        num
       else
         const_class.iterations_count
       end
    end
    
    # Sets time format
    # @param [String] format
    #   '24h':    24-hour format,
    #   '12h':    12-hour format,
    #   '12hNS':  12-hour format with no suffix,
    #   'Float':  floating point number
    def time_format=(format)
      @time_format = if Constants.accepted_time_formats.include?(format)
        format
      else 
        const_class.time_format
      end
    end

    # Sets the invalid time replacement string
    # @param [String] str
    def invalid_time=(str)
      @invalid_time = str || const_class.invalid_time
    end

    # Sets times suffixes
    # @param [Hash] suffixes
    def time_suffixes=(suffixes)
      s = suffixes.reject{|k,v| !(const_class.time_suffixes.key?(k) and v.is_a?(String))} rescue {}
      @time_suffixes = const_class.time_suffixes.merge(s)
    end

    # Sets times names
    # @param [Hash] names
    def times_names=(names)
      s = names.reject{|k,v| !(const_class.times_names.key?(k) and v.is_a?(String))} rescue {}
      @times_names = const_class.times_names.merge(s)
    end

    # Sets times offsets
    # @param [Hash] offsets
    def times_offsets=(offsets)
      s = offsets.reject{|k,v| !(const_class.times_offsets.key?(k) and v.is_a?(Numeric))} rescue {}
      @times_offsets = const_class.times_offsets.merge(s) 
    end

    # Sets calculation method and the corresponding settings
    # @param [String] calc_method the method name
    def calculation_method=(calc_method)
      @calculation_method = if PrayerTimes.calculation_methods.key?(calc_method)
        const_class.calculation_methods[calc_method]
      else
        PrayerTimes.calculation_method
      end
    end 
    
    def const_class #:nodoc:
      raise "Please override this method"
    end
  end
end