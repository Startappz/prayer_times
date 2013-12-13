require_relative '../../test_helper'

describe PrayerTimes::CalculationMethods do
  describe "#initialize" do
    subject{PrayerTimes::CalculationMethods.new}
    it {subject.must_respond_to :add}
    it {subject.keys.must_equal subject.class.default_methods.keys}
    it {subject.must_respond_to :[]}
    it {subject.must_respond_to :each}
    it {subject.must_respond_to :keys}
    it {subject.must_respond_to :key?}
    it {subject.must_respond_to :delete}
  end
  

  
  describe  "#add" do
    before do
      @subject = PrayerTimes::CalculationMethods.new
      @settings = {fajr: 16.5, asr: 'Hanafi', isha: '80 min'}
      @offsets = {dhuhr: 2, asr: -1, isha: 3}

      @new = @subject.add("Test", "Testing method", @settings, @offsets)
    end
    it {@new.must_be_instance_of PrayerTimes::CalculationMethod}
    it {@subject["Test"].must_be_same_as @new}
    it {@subject["Test"].settings[:fajr].must_equal 16.5}
    it {@subject["Test"].settings[:asr].must_equal 'Hanafi'}
    it {@subject["Test"].settings[:isha].must_equal '80 min'}
    it {@subject["Test"].offsets[:dhuhr].must_equal 2}
    it {@subject["Test"].offsets[:asr].must_equal -1}
    it {@subject["Test"].offsets[:isha].must_equal 3}
  end
  
  describe "#names" do
    subject{PrayerTimes::CalculationMethods.new}
    it{subject.names.must_equal subject.keys}
  end
end
