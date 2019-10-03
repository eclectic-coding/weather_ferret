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

  def self.humidity
    (@forecast['currently']['humidity'] * 100).to_i
  end

  def self.wind_speed(key)
    @forecast[key.to_s]['windSpeed'].to_i
  end

  def self.temp_max(num)
    @forecast['daily']['data'][num]['temperatureHigh'].to_i
  end

  def self.temp_min(num)
    @forecast['daily']['data'][num]['temperatureLow'].to_i
  end

  def self.real_feel(num)
    @forecast['daily']['data'][num]['apparentTemperatureHigh'].to_i
  end

  def summary(key)
    @forecast[key.to_s]['summary'].to_s
  end

  # Detail Weather Methods ==============================
  def self.fetch_data(num, key_data)
    @forecast['daily']['data'][num][key_data].to_i
  end

  def self.fetch_sunrise(num)
    time = Time.at(@forecast['daily']['data'][num]['sunriseTime'])
    time.strftime('%I:%M %p')
  end

  def self.fetch_sunset(num)
    time = Time.at(@forecast['daily']['data'][num]['sunsetTime'])
    time.strftime('%I:%M %p')
  end

  # DISPLAY -- Current Weather Section ==============================
  def self.display_curr_table(location)
    @forecast = WeatherFerret::Request.fetch(location)
    curr_table = TTY::Table.new ["\u{1F321} Temp.: #{cur_temp} °F",
                                 "\u{1F321} RealFeel: #{cur_real_feel}°F"],
                                [["\u{1F4A6} Humidity: #{humidity}\u{0025}",
                                  "\u{1F343} Wind Speed: #{wind_speed('currently')}mph"]]
    puts curr_table.render(:ascii, padding: [0, 2])
    puts ''
  end

  # DISPLAY -- Extended Forecast List ==============================
  def self.display_forecast_list
    @forecast['daily'].each do |key, value|
      next unless key == 'data'

      value.each.with_index do |n, index|
        date = Time.at(n['time'])
        puts "#{index + 1})".colorize(:blue) + "#{date.strftime('%a')} - #{date.month}/#{date.day}: High: #{n['temperatureMax'].to_i}°F/Low: #{n['temperatureMin'].to_i}°F Wind Speed: #{n['windSpeed'].to_i}mph"
      end
    end
  end

  # DISPLAY -- Selected Detail Forecast ==============================
  def self.display_details(num)
    num -= 1
    date = Time.at(@forecast['daily']['data'][num]['time'])
    puts "#{date.strftime('%a')} - #{date.month}/#{date.day}".colorize(:blue)
    temp_max(num)
    puts "Hi: #{fetch_data(num, 'temperatureHigh')}°F  Lo: #{fetch_data(num, 'temperatureLow')}°F  ReelFeel: #{fetch_data(num, 'apparentTemperatureHigh')}°F"
    puts "Wind: #{fetch_data(num, 'windSpeed')}mph  Precip Prob.: #{fetch_data(num, 'precipProbability')}\u{0025}  Possible Precip.: #{fetch_data(num, 'precipType')}"
    puts "Humidity: #{fetch_data(num, 'humidity')}\u{0025}  Sunrise: #{fetch_sunrise(num)}  Sunset: #{fetch_sunset(num)}"
    # Build table
  end
end
