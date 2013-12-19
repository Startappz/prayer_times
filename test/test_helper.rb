# encoding: UTF-8
require 'minitest/autorun'
require 'minitest/pride'
require 'coveralls'
Coveralls.wear!
require File.expand_path('../../lib/prayer_times.rb', __FILE__)
class MiniTest::Spec
  class << self
    alias :context :describe
  end
end