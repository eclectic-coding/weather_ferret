require 'tty-table'
require 'pry'

class WeatherFerret::Forecast

  # Current Weather Section ==============================
  def self.cur_temp
    @forecast['currently']['temperature'].to_i
  end

  def self.cur_real_feel
    @forecast['currently']['apparentTemperature'].to_i
  end

  def self.humidity(key)
    (@forecast[key.to_s]['humidity'] * 100).to_i
  end

  def self.wind_speed(key)
    @forecast[key.to_s]['windSpeed'].to_i
  end

  def temp_min
    @forecast['currently']['temperatureHigh'].to_i
  end

  def temp_max
    @forecast['currently']['temperatureLow'].to_i
  end

  def summary
  end

  def self.display_curr_table(location)
    @forecast = WeatherFerret::Request.fetch(location)
    curr_table = TTY::Table.new ["\u{1F321} Temp.: #{cur_temp} °F",
                                 "\u{1F321} RealFeel: #{cur_real_feel}°F"],
                                [["\u{1F4A6} Humidity: #{humidity('currently')}\u{0025}",
                                  "\u{1F343} Wind Speed: #{wind_speed('currently')}mph"]]
    puts ''
    puts ''
    puts "Current Conditions for #{location}:".colorize(:blue)
    puts '====================================='
    puts curr_table.render(:ascii, padding: [0, 2])
    puts ''
  end

  # Extended Forecast List ==============================
  def self.display_forecast_list
    @forecast['daily'].each do |key, value|
      next unless key == 'data'

      value.each.with_index do |n, index|
        # i = n
        date = Time.at(n['time'])
        puts "#{index + 1})".colorize(:red) + " #{date.strftime('%a')} - #{date.month}/#{date.day}".colorize(:blue) + ": High: #{n['temperatureMax'].to_i}°F/Low: #{n['temperatureMin'].to_i}°F Wind Speed: #{n['windSpeed'].to_i}mph"
      end
    end
  end
end
