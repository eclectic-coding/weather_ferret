require 'colorize'
require 'pry'

class WeatherFerret::CLI
  attr_accessor :location, :forecast

  def call
    WeatherFerret::Request.new.list_banner
    menu
  end

  def menu
    puts ''
    puts 'Please enter a city to retrieve a forecast (Format: City State):'
    location = gets.strip

    puts "You entered: #{location}".colorize(:blue) + ' Is this correct (Y/N)?'
    input_confirm = gets.strip.downcase
    if input_confirm == 'n'
      puts 'I am sorry, let us try again.'
      menu
    elsif input_confirm == 'y'
      system('cls') || system('clear')
      puts 'CURRENT WEATHER HERE'
      puts '-------------------------'
      WeatherFerret::Forecast.display_curr_table(location)


      # Extended forecast
      puts 'Extended forecast:'.colorize(:blue)
      puts '--------------------'
      puts ''
      WeatherFerret::Forecast.display_forecast_list
      exit
    else
      puts ''
      puts '<== ERROR ==>'.colorize(:yellow).on_red
      puts 'I do not understand your response, please try again.'
      menu
    end

  end

  # def display_today(location)
  #   @forecast = WeatherFerret::Request.fetch(location)
  #   WeatherFerret::Forecast.display_curr_table
  # end
  #

end
