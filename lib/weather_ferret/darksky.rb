# frozen_string_literal: true

require 'forecast_io'
require 'date'
require 'time'
require 'colorize'
require 'geocoder'

date = Date.today

puts 'Enter the city and/or state you would like to get a forecast for:'
location = gets.chomp
puts '--------'

city = Geocoder.search(location)
latitude = city[0].latitude
longitude = city[0].longitude

ForecastIO.api_key = '4d0f098cae5dc95ab3bc770d3dd3e64c'

forecast = ForecastIO.forecast(latitude, longitude)
forecast = forecast.to_hash

forecast['daily'].each do |key, value|
  next unless key == 'data'

  value.each do |n|
    date = Time.at(n['time'])
    puts "#{date.strftime('%a')} - #{date.month}/#{date.day}".colorize(:blue)
    puts "High: #{n['temperatureMax'].to_i}F\tLow: #{n['temperatureMin'].to_i}F"
    puts n['summary'].to_s
    puts '--------'
  end
end
