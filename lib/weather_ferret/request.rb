require 'forecast_io'
require 'geocoder'
require 'pry'
require 'dotenv'
Dotenv.load('./.env')

# export

class WeatherFerret::Request
  attr_accessor :location

  def initialize(location)
    @location = location
  end

  # Convert user entered location to geodetic coordinates
  def self.coordinate_pts(location)
    city = Geocoder.search(location)
    @lat = city[0].latitude
    @lon = city[0].longitude
  end

  # fetch forecast hash from Dark Sky API
  def self.fetch(location)
    coordinate_pts(location)
    ForecastIO.configure do |c|
      c.api_key = ENV['DSKY_API_KEY']
      c.default_params = { time: 600, exclude: 'minutely, hourly' }
    end
    @forecast = ForecastIO.forecast(@lat, @lon)
  end

end
