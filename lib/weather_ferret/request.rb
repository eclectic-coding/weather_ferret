require 'forecast_io'
require 'geocoder'
require 'csv'
require 'pry'

class WeatherFerret::Request
  attr_accessor :location, :lat, :lon

  def initialize(location)
    @location = location
  end

  def self.today

  end

  def self.coordinate_pts(location)
    city = Geocoder.search(location)
    @lat = city[0].latitude
    @lon = city[0].longitude
    # save_csv(location)
  end

  # def self.save_csv(location)
  #   save_file = CSV.open('db/locations.csv', 'a') do |csv|
  #     csv << [location, @lat, @lon]
  #   end
  #   !save_file.nil?
  # end

  # def self.find_location_csv(location)
  #   csv_read = File.read('db/locations.csv')
  #   csv = CSV.read(csv_read, headers: true)
  #   text = csv.find { |row| row['CITY'] == location }
  #   binding.pry
    # csv_table = CSV.table('db/locations.csv', headers: false)
    # row_name = csv_table.find do |row|
    #   row.field(:city) == location
    # end

    # arr = CSV.read(filename)
    # puts arr.first(location) # 1

    # record = CSV.parse(location)
    #   puts record.to_s
    # end
  # end

  def self.fetch_forecast(location)
    # find_location_csv(location)
    coordinate_pts(location)
    ForecastIO.api_key = '4d0f098cae5dc95ab3bc770d3dd3e64c'
    @forecast = ForecastIO.forecast(@lat, @lon)
    @forecast = @forecast.to_hash
  end

end
