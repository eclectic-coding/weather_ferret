require 'forecast_io'
require 'geocoder'
require 'pry'

class WeatherFerret::Request
  attr_accessor :location

  def initialize(location)
    @location = location
  end

  def self.coordinate_pts(location)
    city = Geocoder.search(location)
    @lat = city[0].latitude
    @lon = city[0].longitude
  end

  def self.fetch(location)
    coordinate_pts(location)
    ForecastIO.configure do |c|
      c.api_key = '4d0f098cae5dc95ab3bc770d3dd3e64c'
      c.default_params = { time: 600, exclude: 'minutely, hourly' }
    end
    @forecast = ForecastIO.forecast(@lat, @lon)
  end

end
