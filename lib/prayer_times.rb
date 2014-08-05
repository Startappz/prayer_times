# encoding: UTF-8
require 'date'
require 'forwardable'
require_relative 'prayer_times/version'
require_relative 'prayer_times/constants'
require_relative 'prayer_times/math_helpers'
require_relative 'prayer_times/calculation_method'
require_relative 'prayer_times/calculation_methods'
require_relative 'prayer_times/setters'
require_relative 'prayer_times/calculator'
require_relative 'prayer_times/calculation'

module PrayerTimes #:nodoc:
  class << self
    include Setters

    attr_reader :iterations_count, :times_names, :calculation_methods,
      :calculation_method, :time_format, :time_suffixes, :times_offsets,
      :invalid_time

    # @see Calculator initializer
    def new(calc_method = @calucation_method, opts = {})
      PrayerTimes::Calculator.new(calc_method, opts)
    end

    def const_class
      Constants
    end

    def set_attributes
      attrs =  [:iterations_count, :times_names, :time_format,
                :time_suffixes, :times_offsets, :invalid_time]
      attrs.each { |attr| send "#{attr}=", nil }

      @calculation_methods = CalculationMethods.new

      @calculation_method = @calculation_methods['MWL']
    end
  end

  set_attributes
end
