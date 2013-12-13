require_relative '../../test_helper'

describe PrayerTimes::MathHelpers do

  subject{ Object.new.extend PrayerTimes::MathHelpers}

  describe "#radians" do
    it {subject.must_respond_to(:radians)}
  end

  describe "#degrees" do
    it {subject.must_respond_to(:degrees)}
  end

  describe "#rsin" do
    it {subject.must_respond_to(:rsin)}
  end
  
  describe "#rcos" do
    it {subject.must_respond_to(:rcos)}
  end
  
  describe "#rtan" do
    it {subject.must_respond_to(:rtan)}
  end
  
  describe "#darcsin" do
    it {subject.must_respond_to(:darcsin)}
  end
  
  describe "#darccos" do
    it {subject.must_respond_to(:darccos)}
  end
  
  describe "#darctan" do
    it {subject.must_respond_to(:darctan)}
  end
  
  describe "#darccot" do
    it {subject.must_respond_to(:darccot)}
  end
  
  describe "#darctan2" do
    it {subject.must_respond_to(:darctan2)}
  end
end
