require 'uri'
require 'json'
require 'date'
require 'httparty'
require_relative 'flight_result'
require_relative 'helpers/core_helper'

class MissingArguments < StandardError; end

module KiwiApi
  module Client
    KIWI_BASE_URL = 'https://api.skypicker.com'
    KIWI_FLIGHTS_PATH = '/flights'
    KIWI_PLACES_PATH = '/places'
    REQUIRED_PARAMS = %i{origin destination date_from}

    # https://api.skypicker.com/places?term=SVQ

    def self.search_flight(origin, destination, date_from, options = {})
      unless origin && destination && date_from
        raise MissingArguments.new("The following params are required: #{REQUIRED_PARAMS}")
      end

      params = {
          flyFrom: origin,
          to: destination,
          dateFrom: date_from,
          dateTo: options[:date_to] || date_from,
          directFlights: 1,
          price_to: options[:max_price_flight] || 150,
          curr: 'EUR',
          # dtimefrom: options[:departure_time_from] || '18:00',
          limit: options[:limit] || 5
          # flyDays: 5,
          # flyDaysType: 'departure',
          # daysInDestinationFrom: 2,
          # returnFlyDays: [0, 1],
          # sort: 'date',
      }

      response = HTTParty.get(KIWI_BASE_URL + KIWI_FLIGHTS_PATH, query: params, verify: false)

      if response.code == 200
        parsed_response = JSON.parse(response.body)
        parsed_response['data'].map { |flight_result_params| FlightResult.new(flight_result_params) }
      else
        puts response.inspect
      end
    end

    private

    def parse_date(date)
      begin
        Date.parse(date).strftime('%d/%m/%Y')
      rescue => e
        raise "Incorrect date value: #{date}"
      end
    end
  end
end
