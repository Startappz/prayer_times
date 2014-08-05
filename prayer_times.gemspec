# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prayer_times/version'

Gem::Specification.new do |spec|
  spec.name          = 'prayer_times'
  spec.version       = PrayerTimes::VERSION
  spec.authors       = ['Khaled alHabache']
  spec.email         = ['khellls@gmail.com']
  spec.description   = %q{Calculates Muslim prayers times in given settings}
  spec.summary       = %q{Muslim prayers times calculator}
  spec.homepage      = 'https://github.com/Startappz/prayer_times/'
  spec.license       = 'GNU LGPL v3.0'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = Dir.glob('spec/**/*')
  spec.require_paths = ['lib']
end
