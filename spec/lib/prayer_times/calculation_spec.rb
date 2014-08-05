# encoding: UTF-8
require_relative '../../test_helper'

# Those results are tested against numbers from the js code
# http://praytimes.org/code/v2/js/PrayTimes.js
describe PrayerTimes::Calculation do
  describe '#compute' do
    context 'when method is MWL' do
      context 'when date is 2011/2/9, location is Waterloo/Canada and timezone -5' do
        let(:pt) { PrayerTimes.new}
        subject{pt.get_times([2011,2,9], [43, -80], -5) }
        let(:expected) { {
                           'Imsak' =>  '05:40',
                           'Fajr' => '05:50',
                           'Sunrise' => '07:26',
                           'Dhuhr' => '12:34',
                           'Asr' => '15:18' ,
                           'Sunset' => '17:43' ,
                           'Maghrib' => '17:43' ,
                           'Isha' => '19:14' ,
        'Midnight' => '00:35' } }
        it {expect(subject).to eq(expected) }
      end
    end

    context 'when method is Makkah' do
      let(:method_name) { 'Makkah'}

      context 'time format is 24h and other settings are default' do
        context 'when date is 2013/12/16, location is Amman/Jordan and timezone 3' do
          let(:pt) { PrayerTimes.new method_name}
          subject{pt.get_times([2013,12,16], [31,36], 3) }
          let(:expected) { {
                             'Imsak' =>  '05:48',
                             'Fajr' => '05:58',
                             'Sunrise' => '07:27',
                             'Dhuhr' => '12:32',
                             'Asr' => '15:18' ,
                             'Sunset' => '17:36' ,
                             'Maghrib' => '17:36' ,
                             'Isha' => '19:06' ,
          'Midnight' => '00:32' } }
          it {expect(subject).to eq(expected) }
        end
      end

      context 'time format is 24h, offsets are custom and other settings are default' do
        context 'when date is 2013/12/16, location is Amman/Jordan and timezone 3' do
          let(:pt) { PrayerTimes.new method_name, times_offsets: {fajr: 4, dhuhr: 2, midnight: 1}}
          subject{pt.get_times([2013,12,16], [31,36], 3) }
          let(:expected) { {
                             'Imsak' =>  '05:48',
                             'Fajr' => '06:02',
                             'Sunrise' => '07:27',
                             'Dhuhr' => '12:34',
                             'Asr' => '15:18' ,
                             'Sunset' => '17:36' ,
                             'Maghrib' => '17:36' ,
                             'Isha' => '19:06' ,
          'Midnight' => '00:33' } }
          it {expect(subject).to eq(expected) }
        end
      end



      context 'time format is 24h, times names are custom and settings are default' do
        context 'when date is 2013/12/16, location is Amman/Jordan and timezone 3' do
          let(:pt) { PrayerTimes.new method_name, times_names: {asr: 'Aser', isha: 'Ishaa'}}
          subject{pt.get_times([2013,12,16], [31,36], 3) }
          let(:expected) { {
                             'Imsak' =>  '05:48',
                             'Fajr' => '05:58',
                             'Sunrise' => '07:27',
                             'Dhuhr' => '12:32',
                             'Aser' => '15:18' ,
                             'Sunset' => '17:36' ,
                             'Maghrib' => '17:36' ,
                             'Ishaa' => '19:06' ,
          'Midnight' => '00:32' } }
          it {expect(subject).to eq(expected) }
        end
      end

      context 'time format is 12h, suffixes are custom and other settings are default' do
        context 'when date is 2013/12/16, location is Amman/Jordan and timezone 3' do
          let(:pt) { PrayerTimes.new method_name, time_format: '12h', time_suffixes: {:am => ' صباحا', :pm => ' مساءا'}}
          subject{pt.get_times([2013,12,16], [31,36], 3) }
          let(:expected) { {
                             'Imsak' => '5:48 صباحا',
                             'Fajr' => '5:58 صباحا',
                             'Sunrise' => '7:27 صباحا',
                             'Dhuhr' => '12:32 مساءا',
                             'Asr' => '3:18 مساءا' ,
                             'Sunset' => '5:36 مساءا' ,
                             'Maghrib' => '5:36 مساءا' ,
                             'Isha' => '7:06 مساءا' ,
          'Midnight' => '12:32 صباحا' }}
          it {expect(subject).to eq(expected) }
        end
      end
    end

    context 'when method is Turkey' do
      context 'when date is 2013/12/17, location is Fatih/Istanbul/Turkey and timezone +2' do
        let(:pt) { PrayerTimes.new 'Turkey', time_format: '12h'}
        subject{pt.get_times([2013,12,17], [41.02,28.94], 2) }
        let(:expected) { {
                           'Imsak' =>  '5:34AM',
                           'Fajr' => '5:42AM',
                           'Sunrise' => '7:16AM',
                           'Dhuhr' => '12:06PM',
                           'Asr' => '2:24PM' ,
                           'Sunset' => '4:37PM' ,
                           'Maghrib' => '4:46PM' ,
                           'Isha' => '6:13PM' ,
        'Midnight' => '12:00AM' }}
        it {expect(subject).to eq(expected) }
      end
    end

    context 'when method is Karachi' do
      context 'when date is 2013/12/17, location is Islamabad, timezone +5 and format is 12h' do
        let(:pt) { PrayerTimes.new 'Karachi', time_format: '12h'}
        subject{pt.get_times([2014,1,23], [33.73,73.06], 5) }
        let(:expected) { {
                           'Imsak' =>  '5:33AM',
                           'Fajr' => '5:43AM',
                           'Sunrise' => '7:10AM',
                           'Dhuhr' => '12:20PM',
                           'Asr' => '3:52PM' ,
                           'Sunset' => '5:30PM' ,
                           'Maghrib' => '5:30PM' ,
                           'Isha' => '6:56PM' ,
        'Midnight' => '12:20AM' } }
        it {expect(subject).to eq(expected) }
      end
    end

    context 'when method is Kula Malaysia' do
      context 'when date is 2013/12/17, location is Kula Lumpur, timezone +8 and format is 12h' do
        let(:pt) { PrayerTimes.new 'Malaysia', time_format: '12h'}
        subject{pt.get_times([2014,1,23], [3.15,101.69], 8) }
        let(:expected) { {
                           'Imsak' =>  '5:54AM',
                           'Fajr' => '6:07AM',
                           'Sunrise' => '7:28AM',
                           'Dhuhr' => '1:26PM',
                           'Asr' => '4:50PM' ,
                           'Sunset' => '7:25PM' ,
                           'Maghrib' => '7:25PM' ,
                           'Isha' => '8:36PM' ,
        'Midnight' => '1:25AM' } }
        it { expect(subject).to eq(expected) }
      end
    end

  end
end
