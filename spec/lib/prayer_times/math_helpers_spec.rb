# encoding: UTF-8
require_relative '../../test_helper'

describe PrayerTimes::MathHelpers do

  subject { Object.new.extend PrayerTimes::MathHelpers }

  describe '#radians' do
    it { expect(subject).to respond_to(:radians) }
  end

  describe '#degrees' do
    it { expect(subject).to respond_to(:degrees) }
  end

  describe '#rsin' do
    it { expect(subject).to respond_to(:rsin) }
  end

  describe '#rcos' do
    it { expect(subject).to respond_to(:rcos) }
  end

  describe '#rtan' do
    it { expect(subject).to respond_to(:rtan) }
  end

  describe '#darcsin' do
    it { expect(subject).to respond_to(:darcsin) }
  end

  describe '#darccos' do
    it { expect(subject).to respond_to(:darccos) }
  end

  describe '#darctan' do
    it { expect(subject).to respond_to(:darctan) }
  end

  describe '#darccot' do
    it { expect(subject).to respond_to(:darccot) }
  end

  describe '#darctan2' do
    it { expect(subject).to respond_to(:darctan2) }
  end
end
