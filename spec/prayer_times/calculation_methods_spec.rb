# encoding: UTF-8
require 'helper'

describe PrayerTimes::CalculationMethods do
  describe '#initialize' do
    subject { PrayerTimes::CalculationMethods.new }
    it { expect(subject).to respond_to(:add) }
    it { expect(subject.keys).to eq(subject.class.default_methods.keys) }
    it { expect(subject).to respond_to(:[]) }
    it { expect(subject).to respond_to(:each) }
    it { expect(subject).to respond_to(:keys) }
    it { expect(subject).to respond_to(:key?) }
    it { expect(subject).to respond_to(:delete) }
  end

  describe '#add' do
    before do
      @subject = PrayerTimes::CalculationMethods.new
      @settings = { fajr: 16.5, asr: 'Hanafi', isha: '80 min' }
      @offsets = { dhuhr: 2, asr: -1, isha: 3 }

      @new = @subject.add('Test', 'Testing method', @settings, @offsets)
    end
    it { expect(@new).to be_a(PrayerTimes::CalculationMethod) }
    it { expect(@subject['Test']).to eq(@new) }
    it { expect(@subject['Test'].settings[:fajr]).to eq(16.5) }
    it { expect(@subject['Test'].settings[:asr]).to eq('Hanafi') }
    it { expect(@subject['Test'].settings[:isha]).to eq('80 min') }
    it { expect(@subject['Test'].offsets[:dhuhr]).to eq(2) }
    it { expect(@subject['Test'].offsets[:asr]).to eq(-1) }
    it { expect(@subject['Test'].offsets[:isha]).to eq(3) }
  end

  describe '#names' do
    subject { PrayerTimes::CalculationMethods.new }
    it { expect(subject.names).to eq(subject.keys) }
  end
end
