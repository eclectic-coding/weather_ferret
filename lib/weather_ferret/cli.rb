require 'colorize'
require 'pry'

class WeatherFerret::CLI
  attr_accessor :location, :forecast

  def call
    list_banner
    menu
  end

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

  def menu
    puts ''
    puts 'Please enter a city to retrieve a forecast (Format: City State):'
    # location = gets.strip
    location = 'Dunn NC'

    # puts "You entered: #{location}".colorize(:blue) + ' Is this correct (Y/N)?'
    # input_confirm = gets.strip.downcase
    input_confirm = 'y'
    if input_confirm == 'n'
      puts 'I am sorry, let us try again.'
      menu
    elsif input_confirm == 'y'
      system('cls') || system('clear')
      puts ''
      puts "Current Conditions for #{location}:".colorize(:blue)
      puts '====================================='
      WeatherFerret::Forecast.display_curr_table(location)

      # Extended forecast List
      puts 'Extended forecast:'.colorize(:blue)
      puts '--------------------'
      WeatherFerret::Forecast.display_forecast_list
      puts ''
      options_menu
    else
      puts '<== ERROR ==>'.colorize(:white).on_red
      begin
        raise WeatherError
      rescue WeatherError => e
        puts e.message
      end
      menu
    end
  end

  def options_menu
    puts ''
    puts 'Would you like additional details about any of the days listed?'.colorize(:blue)
    puts 'Please enter the corresponding number for your request, or any letter to EXIT: '.colorize(:blue)
    detail_input = gets.strip.to_i
    if detail_input.positive? && detail_input < 8
      # puts 'Value input'
      # system('cls') || system('clear')
      WeatherFerret::Forecast.display_details(detail_input)

    elsif detail_input.is_a? Integer
      puts ''
      puts '<== ERROR ==>'.colorize(:white).on_red
      puts 'I do not understand your response, please try again.'
      options_menu
      #   system('cls') || system('clear')
      #   puts 'CURRENT WEATHER HERE'
      #   puts '-------------------------'
      #   WeatherFerret::Forecast.display_curr_table(detail)
      #
      #   # Extended forecast
      #   puts 'Extended forecast:'.colorize(:blue)
      #   puts '--------------------'
      #   puts ''
      #   WeatherFerret::Forecast.display_forecast_list
      else
      #   puts ''
      #   puts '<== ERROR ==>'.colorize(:yellow).on_red
      #   puts 'I do not understand your response, please try again.'
      #   options_menu
    end
    # WeatherFerret::Forecast.display_forecast_list
  end

  class WeatherError < StandardError
    def message
      'I do not understand your response, please try again.'
    end
  end

end
