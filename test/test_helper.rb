# encoding: UTF-8
require 'minitest/autorun'
require 'minitest/pride'
require File.expand_path('../../lib/prayer_times.rb', __FILE__)

class MiniTest::Spec
  class << self
    alias :context :describe
    alias_method :it_with_message, :it
    
    def it(message="",&block)
      it_with_message(message,&block)
    end

  end
end