require 'geocoder'
require 'open_weather'
require 'pry'
require 'faraday'
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
    # city = OpenWeather::Current.city(location, options = { units: 'imperial', APPID: '3d4789029e2e08578efba398668fc1eb' })
    # binding.pry


  end

  # fetch forecast hash from Weather API
  def self.fetch(location)
    options = { units: 'imperial', APPID: '3d4789029e2e08578efba398668fc1eb' }
    city = OpenWeather::Current.city(location, options)
    binding.pry

    # end
  end

end
