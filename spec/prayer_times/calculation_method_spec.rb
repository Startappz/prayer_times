# encoding: UTF-8
require 'helper'

describe PrayerTimes::CalculationMethod do

  let(:method_name) { 'Medina' }
  let(:description) { 'Medina testing methods' }

  describe 'Object' do
    subject { PrayerTimes::CalculationMethod.new(method_name, description, {}) }
    it { expect(subject).to respond_to(:description) }
    it { expect(subject).to respond_to(:description=) }
    it { expect(subject).to respond_to(:settings) }
    it { expect(subject).to respond_to(:settings=) }
    it { expect(subject).to respond_to(:offsets) }
    it { expect(subject).to respond_to(:offsets=) }
  end

  describe '#initialize' do
    context 'when method_name and description are provided' do
      subject { PrayerTimes::CalculationMethod.new(method_name, description) }
      it { expect(subject.name).to eq(method_name) }
      it { expect(subject.description).to eq(description) }
    end

    context 'when settings are not provided' do
      subject { PrayerTimes::CalculationMethod.new(method_name, description, {}) }
      it { expect(subject.settings).to eq(PrayerTimes::CalculationMethod.default_settings) }
    end

    context 'when settings are provided' do
      let(:opts){{
                   fajr:       18,
                   asr:        'Hanafi',
                   isha:       18
      }}
      subject { PrayerTimes::CalculationMethod.new(method_name, description,opts) }
      it { expect(subject.settings).to eq(PrayerTimes::CalculationMethod.default_settings.merge opts) }
    end

    context 'when offsets are not provided' do
      subject { PrayerTimes::CalculationMethod.new(method_name, description, {}, {}) }
      it { expect(subject.offsets).to eq(PrayerTimes::Constants.times_offsets) }
    end

    context 'when offsets are provided' do
      let(:opts){{
                   fajr:       3,
                   asr:        -1,
                   isha:       6
      }}
      subject { PrayerTimes::CalculationMethod.new(method_name, description,{},opts) }
      it { expect(subject.offsets).to eq(PrayerTimes::Constants.times_offsets.merge opts) }
    end

  end

end
