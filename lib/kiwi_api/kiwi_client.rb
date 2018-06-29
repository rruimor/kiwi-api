require 'uri'
require 'json'
require 'date'
require 'faraday'
require_relative 'flight_result'
require_relative 'helpers/core_helper'

module KiwiApi
  module Client
    KIWI_BASE_URL = 'https://api.skypicker.com'
    KIWI_FLIGHTS_PATH = '/flights'
    KIWI_PLACES_PATH = '/places'

    # Returns a list of flight results.
    #
    #   Both snaked_case (:date_to =>) and camelCase (:dateTo =>) keys are accepted for the extra
    #   query params.
    #
    # Example:
    #
    #   KiwiApi::Client.search_flights('AMS', 'IBZ', '23/08/2017', {date_to: '01/09/2017'})
    #
    # @param [String] fly_from Skypicker API id of the departure location. It might be airport codes,
    #   city IDs, two letter country codes, metropolitan codes and radiuses. Example 'AMS'
    #
    # @param [String] to Skypicker api id of the arrival destination. Accepts the same values in the
    #   same format as fly_from parameter. If you don't include any value you'll get results for all the
    #   airports in the world. Example 'IBZ'
    #
    # @param [String] date_from search flights from this date (dd/mm/YYYY). Example: '23/08/2017'
    #
    # @param [Hash] extra_params to be added to the search query.
    # @option extra_params [String] :date_to the end date (dd/mm/YYYY) to find the departures flights.
    #   If missing, it will be set to the same value as date_from.
    # @option extra_params [Integer] :direct_flights default to 1 (only direct flights), 0 value for
    #   including non-direct flights.
    # @option extra_params [Integer] :fly_Days it filters the days of the week to flight, starting by
    #   0 for Sundays. Example flyDays: 5 (for only Fridays flights).
    #
    # @see http://docs.skypickerpublicapi.apiary.io/#reference/flights/flights/get for full list of
    #   extra params.
    #
    # @return [FlightResult] returns an array of FlightResult
    def self.search_flights(fly_from, to, date_from, extra_params = {})
      conn = Faraday.new(KIWI_BASE_URL)

      params = {
        fly_from: fly_from,
        to: to,
        date_from: date_from,
        date_to: extra_params[:date_to] || date_from,
        direct_flights: 1,
      }.merge(extra_params).camelize_keys

      response = conn.get(KIWI_FLIGHTS_PATH, params)

      if response.success?
        JSON.parse(response.body)['data'].map { |flight_result_hash| FlightResult.new(flight_result_hash)}
      else
        raise "Something went wrong."
      end
    end

  end
end
