# encoding: UTF-8
require 'helper'

describe PrayerTimes::Setters do

  subject{ PrayerTimes::Calculator.new 'MWL',{} }
  describe '#iteration_count=' do
    context 'when number not number or out of range' do
      ['',1,6].each do |num|
        let(:iterations_count) { 8  }
        let(:result) { subject.iterations_count = iterations_count; subject.iterations_count }
        it { expect(result).to eq(PrayerTimes.iterations_count)  }
      end
    end

    context 'when in range' do
      let(:iterations_count) { 3  }
      let(:result) { subject.iterations_count = iterations_count; subject.iterations_count }
      it { expect(result).to eq(iterations_count)  }
    end
  end

  describe '#time_format=' do
    context 'when wrong value' do
      let(:time_format) { 'kh'  }
      let(:result) { subject.time_format = time_format; subject.time_format }
      it { expect(result).to eq(PrayerTimes.time_format)  }
    end

    context 'when right value' do
      let(:time_format) { '12h'  }
      let(:result) { subject.time_format = time_format; subject.time_format }
      it { expect(result).to eq(time_format)  }
    end
  end

  describe '#invalid_time=' do
    context 'when nil' do
      let(:invalid_time) { nil }
      let(:result) { subject.invalid_time = invalid_time; subject.invalid_time }
      it { expect(result).to eq(PrayerTimes.invalid_time)  }
    end

    context 'when other value' do
      let(:invalid_time) { '*****'  }
      let(:result) { subject.invalid_time = invalid_time; subject.invalid_time }
      it { expect(result).to eq(invalid_time)  }
    end
  end

  describe '#time_suffixes=' do
    context 'when wrong value' do
      let(:time_suffixes) { {:amz => 'صباحا', :pm => 'مساءا' } }
      let(:result) { subject.time_suffixes = time_suffixes; subject.time_suffixes }
      it { expect(result).to eq(PrayerTimes.time_suffixes.merge({:pm => 'مساءا' }))  }
    end

    context 'when right value' do
      let(:time_suffixes) { {:am => 'صباحا', :pm => 'مساءا' } }
      let(:result) { subject.time_suffixes = time_suffixes; subject.time_suffixes }
      it { expect(result).to eq(PrayerTimes.time_suffixes.merge(time_suffixes))  }
    end
  end

  describe '#times_names=' do
    context 'when wrong value' do
      let(:times_names) { {:aser => 'Aser', :koko => 'Dano', :isha => 'Ishaa' } }
      let(:result) { subject.times_names = times_names; subject.times_names }
      it { expect(result).to eq(PrayerTimes.times_names.merge({:isha => 'Ishaa' }))  }
    end

    context 'when right value' do
      let(:times_names) { {:asr => 'Aser', :isha => 'Ishaa' } }
      let(:result) { subject.times_names = times_names; subject.times_names }
      it { expect(result).to eq(PrayerTimes.times_names.merge(times_names))  }
    end
  end

  describe '#times_offsets=' do
    context 'when wrong value' do
      let(:times_offsets) { {:aser => 10, :dhuhr => 'Dano', :isha => 3.6} }
      let(:result) { subject.times_offsets = times_offsets; subject.times_offsets }
      it { expect(result).to eq(PrayerTimes.times_offsets.merge({:isha => 3.6}))  }
    end

    context 'when right value' do
      let(:times_offsets) { {:asr => 1, :dhuhr => 1.2, :isha => 3.6} }
      let(:result) { subject.times_offsets = times_offsets; subject.times_offsets }
      it { expect(result).to eq(PrayerTimes.times_offsets.merge(times_offsets))  }
    end
  end

  describe '#calculation_method=' do
    context 'when wrong value' do
      let(:calculation_method) { 'K@mp'  }
      let(:result) { subject.calculation_method = calculation_method; subject.calculation_method }
      it { expect(result).to eq(PrayerTimes.calculation_method)  }
    end

    context 'when right value' do
      let(:calculation_method) { 'Makkah'  }
      let(:result) { subject.calculation_method = calculation_method; subject.calculation_method }
      it { expect(result).to eq(PrayerTimes.calculation_methods['Makkah'])  }
    end
  end
end
