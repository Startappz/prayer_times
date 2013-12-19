# encoding: UTF-8
require_relative '../../test_helper'

describe PrayerTimes::CalculationMethod do
  
  let(:method_name){"Medina"}
  let(:description){"Medina testing methods"}
  
  describe "Object" do
    subject{PrayerTimes::CalculationMethod.new(method_name, description,{})}
    it {subject.must_respond_to :description}
    it {subject.must_respond_to :description=}
    it {subject.must_respond_to :settings}
    it {subject.must_respond_to :settings=}
    it {subject.must_respond_to :offsets}
    it {subject.must_respond_to :offsets=}
  end
  
  describe "#initialize" do
    context "when method_name and description are provided" do
      subject{PrayerTimes::CalculationMethod.new(method_name, description)}
      it {subject.name.must_equal(method_name)}
      it {subject.description.must_equal(description)}
    end
    
    context "when settings are not provided" do
      subject{PrayerTimes::CalculationMethod.new(method_name, description, {})}
      it {subject.settings.must_equal(PrayerTimes::CalculationMethod.default_settings)}
    end
       
    context "when settings are provided" do
      let(:opts){{
         fajr:       18,
         asr:        'Hanafi',
         isha:       18
      }}
      subject{PrayerTimes::CalculationMethod.new(method_name, description,opts)}
      it {subject.settings.must_equal(PrayerTimes::CalculationMethod.default_settings.merge opts)}
    end   
    
    context "when offsets are not provided" do
      subject{PrayerTimes::CalculationMethod.new(method_name, description, {}, {})}
      it {subject.offsets.must_equal(PrayerTimes::Constants.times_offsets)}
    end
       
    context "when offsets are provided" do
      let(:opts){{
         fajr:       3,
         asr:        -1,
         isha:       6
      }}
      subject{PrayerTimes::CalculationMethod.new(method_name, description,{},opts)}
      it {subject.offsets.must_equal(PrayerTimes::Constants.times_offsets.merge opts)}
    end     
       
  end

end
