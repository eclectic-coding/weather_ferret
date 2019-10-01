require 'forecast_io'
require 'geocoder'
require 'pry'

class WeatherFerret::Request
  attr_accessor :location, :lat, :lon

  def initialize(location)
    @location = location
  end

  def self.coordinates(location)
    city = Geocoder.search(location)
    @lat = city[0].latitude
    @lon = city[0].longitude
    # fetch
  end

  def self.fetch_forecast(location)
    coordinates(location)
    ForecastIO.api_key = '4d0f098cae5dc95ab3bc770d3dd3e64c'
    @forecast = ForecastIO.forecast(@lat, @lon)
    @forecast = @forecast.to_hash
  end

end
