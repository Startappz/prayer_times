PrayerTimes [![Build Status](https://travis-ci.org/Startappz/prayer_times.png?branch=master)](https://travis-ci.org/Startappz/prayer_times) [![Dependency Status](https://gemnasium.com/Startappz/prayer_times.png)](https://gemnasium.com/Startappz/prayer_times) [![Coverage Status](https://coveralls.io/repos/Startappz/prayer_times/badge.png)](https://coveralls.io/r/Startappz/prayer_times)
===

Flexible and configurable calculation for Muslim prayers times.

## Installation

Add this line to your application's Gemfile:

    gem 'prayer_times'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install prayer_times

## Usage

### Baisc usage

```ruby
require 'prayer_times'
pt = PrayerTimes.new("Makkah")
times = pt.get_times(Date.today(), [31,36], 3)
puts times.inspect
```

### Global configuration

You can have a [global configuration](https://github.com/Startappz/prayer_times/wiki/Global-Configuration) through the PrayerTimes module:

```ruby
require 'prayer_times'
PrayerTimes.time_format = '12h'
PrayerTimes.time_suffixes = {:am => 'صباحا', :pm => 'مساءا'}
# and others...
```
#### Adding more methods

There are [several methods](https://github.com/Startappz/prayer_times/wiki/Calculation-Methods) that are shiped with this gem by default. You can list, add new or update existing ones.

```ruby
PrayerTimes.calculation_methods
PrayerTimes.calculation_methods.names
PrayerTimes.calculation_methods.add("Test", "Testing method", fajr: 16.5, asr: 'Hanafi', isha: '80 min') 
new_method = PrayerTimes.calculation_methods["Test"]
new_method.description = "new description"
new_method.settings = {fajr: 19.5, isha: '33 min'}
PrayerTimes.calculation_methods.delete("Test")
```

### Instance configuration

As with the global configuration, you can [set](https://github.com/Startappz/prayer_times/wiki/Instance-Configuration) the configuration on the object level:

```ruby
require 'prayer_times'
PrayerTimes.time_format = '12h'
PrayerTimes.time_suffixes = {am: 'صباحا', pm: 'مساءا'}
options = {
	time_format: '12h',
	time_suffixes: {am: => 'صباحا', pm: 'مساءا'}
	# and others...
}
pt = PrayerTimes.new("Makkah", options)
```

## Help

Your help is appreciated, specially in adjusting the calculation methods and making them more accurate. 
Your contribution is welcome.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
