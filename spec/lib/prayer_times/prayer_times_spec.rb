# encoding: UTF-8
require_relative '../../test_helper'

describe PrayerTimes do

  describe "Class" do
    subject{PrayerTimes}
    it {expect(subject).to respond_to(:calculation_method)}
    it {expect(subject).to respond_to(:calculation_methods)}
    it {expect(subject).to respond_to(:time_format)}
    it {expect(subject).to respond_to(:times_names)}
    it {expect(subject).to respond_to(:time_suffixes)}
    it {expect(subject).to respond_to(:invalid_time)}
    it {expect(subject).to respond_to(:iterations_count)}
    it {expect(subject).to respond_to(:times_offsets)}
    it {expect(subject).to be_a(PrayerTimes::Setters)}
  end

  describe ".new" do
    subject{PrayerTimes.new}
    it{expect(subject).to be_a(PrayerTimes::Calculator)}
  end

end
