require 'colorize'

class WeatherFerret::CLI

  def call
    list_banner
    list_intro
    edit_settings
  end

  def list_banner
    puts 'Weather Ferret Banner'
  end

  def list_intro
    puts ''
    puts 'Introductions and Directions'.colorize(:blue)
    puts '---------------------------------------------------------------------'
    puts 'WEATHER FERRET is your own personal weather assistant.'
    puts 'Enter a city, or zip code below for for the current weather forecast'
    puts 'The results will default to the Units of your Geographical Area.'
    puts '---------------------------------------------------------------------'
  end

  def edit_settings
    puts 'The forecast units will default to your current location (i.e mph/kph)'.colorize(:cyan)
    puts 'EXPAND NOTE'
    puts 'Do you wish to override? (yes/NO)'
  end

end
