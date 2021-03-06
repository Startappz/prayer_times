# encoding: UTF-8
require 'helper'

describe PrayerTimes::Calculator do

  subject { PrayerTimes::Calculator.new 'MWL', {} }
  it { expect(subject).to respond_to(:calculation_method) }
  it { expect(subject).to respond_to(:time_format) }
  it { expect(subject).to respond_to(:times_names) }
  it { expect(subject).to respond_to(:time_suffixes) }
  it { expect(subject).to respond_to(:invalid_time) }
  it { expect(subject).to respond_to(:iterations_count) }
  it { expect(subject).to respond_to(:times_offsets) }
  it { expect(subject).to respond_to(:get_times) }
  it { expect(subject).to be_a(PrayerTimes::Setters) }

end
