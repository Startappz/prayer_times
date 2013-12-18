# encoding: UTF-8
module PrayerTimes
  # Math helpers module
  module MathHelpers
    # Calculates radians from degrees
    # @param [Float] x
    # @return [Float]
    def radians(x) ; x * Math::PI/180 ; end

    # Calculates degrees from radians
    # @param [Float] x
    # @return [Float]
    def degrees(x) ; x * 180/Math::PI ; end

    # Calculates sin in radians
    # @param [Float] x
    # @return [Float]
    def rsin(x); Math.sin(radians x) ; end

    # Calculates cos in radians
    # @param [Float] x
    # @return [Float]
    def rcos(x); Math.cos(radians x) ; end

    # Calculates tan in radians
    # @param [Float] x
    # @return [Float]
    def rtan(x); Math.tan(radians x) ; end

    # Calculates arcsin in degrees
    # @param [Float] x
    # @return [Float]
    def darcsin(x); degrees Math.asin(x) ; end

    # Calculates arccos in degrees
    # @param [Float] x
    # @return [Float]
    def darccos(x); degrees Math.acos(x) ; end

    # Calculates arctan in degrees
    # @param [Float] x
    # @return [Float]
    def darctan(x); degrees Math.atan(x) ; end

    # Calculates arccot in degrees
    # @param [Float] x
    # @return [Float]
    def darccot(x); degrees Math.atan(1.0/x) ; end

    # Calculates arctan2 in degrees
    # @param [Float] x
    # @param [Float] y
    # @return [Float]
    def darctan2(y, x); degrees Math.atan2(y, x) ; end
  end
end