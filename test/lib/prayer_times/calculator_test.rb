# encoding: UTF-8
require_relative '../../test_helper'

describe PrayerTimes::Calculator do

      subject{PrayerTimes::Calculator.new "MWL",{}}
      it{subject.must_respond_to :calculation_method}
      it{subject.must_respond_to :time_format}
      it{subject.must_respond_to :times_names}
      it{subject.must_respond_to :time_suffixes}
      it{subject.must_respond_to :invalid_time}
      it{subject.must_respond_to :iterations_count}
      it{subject.must_respond_to :times_offsets}
      it{subject.must_respond_to :get_times}
      it{subject.must_be_kind_of PrayerTimes::Setters}
      
end
