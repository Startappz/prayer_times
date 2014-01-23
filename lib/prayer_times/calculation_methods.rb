# encoding: UTF-8
module PrayerTimes
  # Helper class to initiate a list of calculation methods and add/update others
  class CalculationMethods
    extend Forwardable
    def_delegators :@hash, :[], :length, :each, :key?, :keys, :delete, :to_s

    # default methods defined in this gem
    # Methods MWL, ISNA, Egypt, Makkah, Karachi, Tehran and Jafari are accurate
    # Other methods need validation. Your help is appreciated.
    def self.default_methods
      {
        "MWL" =>{
          desc: 'Muslim World League',
          settings: {fajr: 18, isha: 17}
        },
        'ISNA' => {
          desc: 'Islamic Society of North America (ISNA)',
          settings: {fajr: 15, isha: 15}
        },
        'Egypt' => {
          desc: 'Egyptian General Authority of Survey',
          settings: {fajr: 19.5, isha: 17.5}
        },
        'Makkah' => {
          desc: 'Umm Al-Qura University, Makkah',
          settings: {fajr: 18.5, isha: '90 min'}  # fajr was 19 degrees before 1430 hijri
        },
        'Karachi' => {
          desc: 'University of Islamic Sciences, Karachi',
          settings: {fajr: 18, asr: 'Hanafi', isha: 18}
        },
        'Tehran' => {
          desc: 'Institute of Geophysics, University of Tehran',
          settings: {fajr: 17.7, maghrib: 4.5, isha: 14, midnight: 'Jafari'}  # isha is not explicitly specified in this method
        },
        'Jafari' => {
          desc: 'Shia Ithna-Ashari, Leva Institute, Qum',
          settings: {fajr: 16, maghrib: 4, isha: 14, midnight: 'Jafari'}
        },
        'UOIF' =>{
          desc: "UNION DES ORGANISATIONS ISLAMIQUES DE FRANCE",
          settings: {fajr: 19, maghrib: '0 min', isha: 17}
        },
        'Algeria' =>{
          desc: "Algeria",
          settings: {fajr: 18, maghrib: '3 min',  isha: 17}
        },
        'EmirateDubai' =>{
          desc: "Emirate, Dubai",
          settings: {fajr: 18.5, maghrib: '0 min',  isha: '90 min'},
          offsets: {dhuhr: 4, asr: 5, maghrib: 2}
        },
        'Emirates' =>{
          desc: "Emirates",
          settings: {fajr: 18.5, maghrib: '0 min',  isha: '90 min'},
          offsets: {asr: 4, maghrib: 2}
        },
        'EnglandBirmingham' =>{
          desc: "England, Birmingham",
          settings: {fajr: 5, maghrib: '0 min',  isha: 84},
          offsets: {fajr: -60, isha: 60}
        },
        'Jordan' =>{
          desc: "General Iftaa' Department, The Hashemite Kingdom of Jordan",
          settings: {fajr: 18, maghrib: '0 min', isha: 18}
        },
        'Kuwait' =>{
          desc: "Kuwait",
          settings: {fajr: 18, maghrib: '0 min', isha: 17.5}
        },
        'Libya' =>{
          desc: "Libya",
          settings: {fajr: 18.5, maghrib: '0 min',  isha: 18.5},
          offsets: { dhuhr: 4, maghrib: 4}
        },
        'Malaysia' =>{
          desc: "Malaysia",
          settings: {fajr: 20, maghrib: '0 min',  isha: 18},
          offsets: {fajr: 3, sunrise: 2, dhuhr: 1, asr: 2, maghrib: 1, isha: -1}
        },
        'Maldives' =>{
          desc: "Maldives",
          settings: {fajr: 19, maghrib: '0 min',  isha: 19},
          offsets: {sunrise: -1, dhuhr: 4, asr: 1, maghrib: 1, isha: 1}
        },
        'Morocco' =>{
          desc: "Morocco",
          settings: {fajr: 19, maghrib: '0 min',  isha: 17},
          offsets:  {fajr: -1, sunrise: -2, dhuhr: 5, maghrib: 3}
        },
        'Oman' =>{
          desc: "Oman",
          settings: {fajr: 18, maghrib: '5 min',  isha: 18},
          offsets: {dhuhr: 5, asr: 5, isha: 1}
        },
        'Qatar' =>{
          desc: "Qatar",
          settings: {fajr: 18, maghrib: '0 min',  isha: '90 min'}
        },
        'Tunisia' =>{
          desc: "Tunisia",
          settings: {fajr: 18, maghrib: '1 min',  isha: 18},
          offsets:  {fajr: -1, sunrise: -2, dhuhr: 8, isha: 1}
        },
        'Turkey' =>{
          desc: "Presidency of Religious Affairs, Turkey",
          settings: {fajr: 18, maghrib: '9 min',  isha: 17},
          offsets: {fajr: -2, sunrise: -7, dhuhr: 6, asr: 4, isha: 2}
        }
      }
    end

    # Initializer
    # it populates a hash with predefined set of methods
    def initialize
      self.hash = {}
      populate
    end

    # @param [String] name
    # @param [String] description
    # @param [Hash] settings
    # @param [Hash] offsets
    # @see CalculationMethod
    def add(name, description, settings={}, offsets={})
      hash[name] = CalculationMethod.new(name, description, settings, offsets)
    end

    # Names of the available methods
    # @return [Array] list of names
    def names
      keys
    end

    private

    attr_accessor :hash

    def populate
      self.class.default_methods.each {|k,v| add(k, v[:desc], v[:settings], v[:offsets])}
    end

  end
end
