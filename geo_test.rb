require 'httparty'
require 'pry'

weather_url = 'https://api.openweathermap.org/data/2.5/find?q=Wilmington&NC&units=imperial&appid=3d4789029e2e08578efba398668fc1eb'
weather = HTTParty.get(weather_url)
puts "Latitude: #{weather['list'][0]['coord']['lat']}"
puts "Longitude: #{weather['list'][0]['coord']['lon']}"
