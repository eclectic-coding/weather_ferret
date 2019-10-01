require 'colorize'
require 'pry'

class WeatherFerret::CLI

  def call
    list_banner
    list_intro
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
  end

  def list_intro
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
    puts 'Please enter a city for a forecast (Format: City State):'
    location = gets.strip

    puts "You entered: #{location}".colorize(:blue) + ' Is this correct (Y/N)?'
    input_confirm = gets.strip.downcase
    if input_confirm == 'n'
      puts 'I am sorry, let us try again.'
      menu
    elsif input_confirm == 'y'
      puts 'Here is your forecast:'.colorize(:blue)
      display_forecast(location)
      exit
    else
      puts ''
      puts '<== ERROR ==>'.colorize(:yellow).on_red
      puts 'I do not understand your response, please try again.'
      menu
    end
  end

  def display_forecast(location)
    @forecast = WeatherFerret::Request.fetch_forecast(location)
    @forecast['daily'].each do |key, value|
      next unless key == 'data'

      value.each do |n|
        date = Time.at(n['time'])
        puts "#{date.strftime('%a')} - #{date.month}/#{date.day}".colorize(:blue)
        puts "High: #{n['temperatureMax'].to_i}F\tLow: #{n['temperatureMin'].to_i}F"
        puts n['summary'].to_s
        puts ''
      end
    end
  end

end
