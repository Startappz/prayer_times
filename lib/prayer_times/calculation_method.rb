# encoding: UTF-8
module PrayerTimes
  # Calculation method instances and logic is encapsulated here
  class CalculationMethod
    attr_reader :name, :description, :settings, :offsets
    attr_writer :description

    # Default settings
    def self.default_settings
      {
        imsak:      '10 min',
        dhuhr:      '0 min',
        asr:        'Standard',
        maghrib:    '0 min',
        midnight:   'Standard',
        high_lats:  'NightMiddle'
      }
    end

    # Initializer
    # @param [String] name
    # @param [String] description
    # @param [Hash] settings
    # @option settings [String] :imsak
    # @option settings [String] :fajr
    # @option settings [String] :sunrise
    # @option settings [String] :dhuhr
    # @option settings [String] :asr Asr Juristic Methods:
    #   'Standard':  Shafi`i, Maliki, Ja`fari and Hanbali,
    #   'Hanafi':    Hanafi
    # @option settings [String] :sunset
    # @option settings [String] :maghrib
    # @option settings [String] :isha
    # @option settings [String] :midnight Midnight Mode:
    #   'Standard':     Mid Sunset to Sunrise,
    #   'Jafari':       Mid Sunset to Fajr
    # @option settings [String] :high_lights Adjust Methods for Higher Latitudes:
    #   'NightMiddle': middle of night,
    #   'AngleBased':  angle/60th of night,
    #   'OneSeventh':   1/7th of night,
    #   'None'
    # @param [Hash] offsets
    # @option offsets [String] :imsak
    # @option offsets [String] :fajr
    # @option offsets [String] :sunrise
    # @option offsets [String] :dhuhr
    # @option offsets [String] :asr
    # @option offsets [String] :sunset
    # @option offsets [String] :maghrib
    # @option offsets [String] :isha
    # @option offsets [String] :midnight
    def initialize(name,description,settings={}, offsets = {})
      self.name = name
      self.description = description
      self.settings = settings
      self.offsets = offsets
    end

    # Sets times settings
    # @param [Hash] settings
    # Check the initializer
    def settings=(settings)
      s = settings.reject{|k,v| !(Constants.times_names.key?(k))} rescue {}
      @settings = self.class.default_settings.merge(s)
    end

    # Sets times offsets
    # @param [Hash] offsets
    # Check the initializer
    def offsets=(offsets)
      s = offsets.reject{|k,v| !(Constants.times_offsets.key?(k) and v.is_a?(Numeric))} rescue {}
      @offsets = Constants.times_offsets.merge(s)
    end


    # @return readable representation of this object
    def to_s
      name
    end

    private

    attr_writer :name

  end
end
