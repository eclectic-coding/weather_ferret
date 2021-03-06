# frozen_string_literal: true

require "tty-spinner"
require "tty-table"
require "pry"

module WeatherFerret
  class Forecast

    # Current Weather Data ==============================
    def self.fetch_curr_data(key_data)
      @forecast["currently"][key_data].to_i
    end

    # Detail Weather Methods ==============================
    def self.fetch_data(num, key_data)
      @forecast["daily"]["data"][num][key_data]
    end

    def self.fetch_sun_data(num, key_data)
      time = Time.at(@forecast["daily"]["data"][num][key_data])
      time.strftime("%I:%M %p")
    end

    # DISPLAY -- Current Weather Section ==============================
    def self.display_curr_table(location)
      ## Add TTY Spinner
      spinner = TTY::Spinner.new("[:spinner] Fetch from API",
                                 format: :bouncing_ball, clear: true)
      20.times do
        spinner.spin
        sleep(0.1)
      end
      spinner.success

      @forecast = WeatherFerret::Request.fetch(location)
      curr_table = TTY::Table.new ["\u{1F321} Temp.: #{fetch_curr_data('temperature')} °F",
                                   "\u{1F321} Heat Index: #{fetch_curr_data('apparentTemperature')}°F"],
                                  [["\u{1F4A6} Humidity: #{fetch_curr_data('humidity')}\u{0025}",
                                    "\u{1F343} Wind Speed: #{fetch_curr_data('windSpeed')}mph"]]
      puts curr_table.render(:ascii, padding: [0, 2])
      puts ""
    end

    # DISPLAY -- Extended Forecast List ==============================
    def self.display_forecast_list
      @forecast["daily"].each do |key, value|
        next unless key == "data"

        value.each.with_index do |n, index|
          date = Time.at(n["time"])
          puts "#{index + 1})".colorize(:blue) + " #{date.strftime('%a')} - #{date.month}/#{date.day}: High: #{n['temperatureMax'].to_i}°F/Low: #{n['temperatureMin'].to_i}°F Wind Speed: #{n['windSpeed'].to_i}mph"
        end
      end
    end

    # DISPLAY -- Selected Detail Forecast ==============================
    def self.display_details(num)
      num -= 1
      date = Time.at(@forecast["daily"]["data"][num]["time"])
      puts ""
      puts " Detailed forecast on #{date.strftime('%a')} - #{date.month}/#{date.day}".colorize(:blue)
      puts " ==========================================".colorize(:blue)

      # Build table
      detail_table = TTY::Table.new do |t|
        t << ["Hi: #{fetch_data(num, 'temperatureHigh').to_i}°F",
              "Lo: #{fetch_data(num, 'temperatureLow').to_i}°F",
              "Heat Index: #{fetch_data(num, 'apparentTemperatureHigh').to_i}°F"]
        t << ["Wind: #{fetch_data(num, 'windSpeed').to_i}mph",
              "Precip Prob.: #{(fetch_data(num, 'precipProbability') * 100).to_i}\u{0025}",
              "Precip.: #{fetch_data(num, 'precipType').to_s.capitalize}"]
        t << ["Humidity: #{fetch_data(num, 'humidity').to_i}\u{0025}",
              "Sunrise: #{fetch_sun_data(num, 'sunriseTime')}", "Sunset: #{fetch_sun_data(num, 'sunsetTime')}"]
      end
      puts detail_table.render(:ascii, padding: [0, 2]) { |renderer|
        renderer.border.separator = :each_row
        renderer.border.style = :cyan
      }
      puts "    #{fetch_data(num, 'summary')}".colorize(:red)
      puts ""
      display_forecast_list
      puts ""
    end
  end
end
