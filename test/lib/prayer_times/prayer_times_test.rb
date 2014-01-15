# encoding: UTF-8
require_relative '../../test_helper'

describe PrayerTimes do

  describe "Class" do
    subject{PrayerTimes}
    it{subject.must_respond_to :calculation_method}
    it{subject.must_respond_to :calculation_methods}
    it{subject.must_respond_to :time_format}
    it{subject.must_respond_to :times_names}
    it{subject.must_respond_to :time_suffixes}
    it{subject.must_respond_to :invalid_time}
    it{subject.must_respond_to :iterations_count}
    it{subject.must_respond_to :times_offsets}
    it{subject.must_be_kind_of PrayerTimes::Setters}
  end

  describe ".new" do
    subject{PrayerTimes.new}
    it{subject.must_be_kind_of PrayerTimes::Calculator}
  end

end
