# frozen_string_literal: true

require "geocoder"
require "pry"
require "faraday"
require "dotenv"
Dotenv.load("./.env")

# export

module WeatherFerret
  class Request
    attr_accessor :location

    def initialize(location)
      @location = location
    end

    # Convert user entered location to geodetic coordinates
    def self.coordinate_pts(location) end

    # fetch forecast hash from Weather API
    def self.fetch(location) end

  end
end
