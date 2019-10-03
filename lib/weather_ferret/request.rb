require 'forecast_io'
require 'geocoder'
require 'pry'

class WeatherFerret::Request
  attr_accessor :location, :lat, :lon

  def list_banner
    puts ''
    puts '  _       __           __  __                 ______                    __ '.colorize(:yellow)
    puts ' | |     / /__  ____ _/ /_/ /_  ___  _____   / ____/__  _____________  / /_'.colorize(:yellow)
    puts ' | | /| / / _ \/ __ `/ __/ __ \/ _ \/ ___/  / /_  / _ \/ ___/ ___/ _ \/ __/'.colorize(:yellow)
    puts ' | |/ |/ /  __/ /_/ / /_/ / / /  __/ /     / __/ /  __/ /  / /  /  __/ /_  '.colorize(:yellow)
    puts ' |__/|__/\___/\__,_/\__/_/ /_/\___/_/     /_/    \___/_/  /_/   \___/\__/  '.colorize(:yellow)
    puts ''
    puts ''
    puts ' Introduction and Directions'.colorize(:blue)
    puts '---------------------------------------------------------------------'.colorize(:white)
    puts ''
    puts ' WEATHER FERRET is your own personal weather assistant.'.colorize(:white)
    puts ' Enter a location below for the current weather forecast'.colorize(:white)
    # puts ' The forecast units will default to your location (i.e mph/kph)'.colorize(:cyan)
    puts '---------------------------------------------------------------------'.colorize(:white)
    puts ''
  end

  # def initialize(location)
  #   @location = location
  # end

  def self.coordinate_pts(location)
    city = Geocoder.search(location)
    @lat = city[0].latitude
    @lon = city[0].longitude
  end

  def self.fetch(location)
    coordinate_pts(location)
    ForecastIO.api_key = '4d0f098cae5dc95ab3bc770d3dd3e64c'
    @forecast = ForecastIO.forecast(@lat, @lon)
  end

end
