require 'colorize'
require 'pry'
# require 'myweatherforecast'
# require 'darksky-api'
# DarkSky.config '4d0f098cae5dc95ab3bc770d3dd3e64c'

class WeatherFerret::CLI

  def call
    list_banner
    list_intro
    start
    # print_temp
  end

  def list_banner
    puts ''
    puts '  _       __           __  __                 ______                    __ '.colorize(:yellow)
    puts ' | |     / /__  ____ _/ /_/ /_  ___  _____   / ____/__  _____________  / /_'.colorize(:yellow)
    puts ' | | /| / / _ \/ __ `/ __/ __ \/ _ \/ ___/  / /_  / _ \/ ___/ ___/ _ \/ __/'.colorize(:yellow)
    puts ' | |/ |/ /  __/ /_/ / /_/ / / /  __/ /     / __/ /  __/ /  / /  /  __/ /_  '.colorize(:yellow)
    puts ' |__/|__/\___/\__,_/\__/_/ /_/\___/_/     /_/    \___/_/  /_/   \___/\__/  '.colorize(:yellow)
    puts ''
  end

  def list_intro
    puts ''
    puts ' Introduction and Directions'.colorize(:blue)
    puts '---------------------------------------------------------------------'.colorize(:white)
    puts ''
    puts ' WEATHER FERRET is your own personal weather assistant.'.colorize(:white)
    puts ' Enter a location below for the current weather forecast'.colorize(:white)
    puts ' The forecast units will default to your location (i.e mph/kph)'.colorize(:cyan)
    puts '---------------------------------------------------------------------'.colorize(:white)
    puts ''
  end

  def start
    puts ''
    puts 'Please enter a city for a forecast (Format: City State):'
    input_city = gets.strip
    puts "You entered: #{input_city}".colorize(:blue) + ' Is this correct (Y/N)?'
    input_city_confirm = gets.strip.downcase
    if input_city_confirm == 'n'
      puts 'I am sorry, let us try again.'
      start
    elsif input_city_confirm == 'y'
      puts 'Here is your forecast:'.colorize(:blue)
      exit
    else
      puts ''
      puts 'I do not understand your response.'
      start
    end
  end

  # Using MyWeatherForecast
  # def print_temp
  #   loc = MyWeatherForecast.new 'Whiteville, NC', api_key: '4d0f098cae5dc95ab3bc770d3dd3e64c'
  #   puts loc.days.take 3
  #   puts '--------------------'
  #   puts "Current Conditions: ICON #{loc.now}"
  # end

  # def print_temp
  #   nyc = DarkSky::Location.new [40.7828687, -73.9675438]
  #   puts "temperature: #{nyc.current.temperature}" # actual air temperature
  #   puts "feels like: #{nyc.current.feels_like}" # apparent temperature
  # end

end
