require 'uri'
require 'json'
require 'date'
require 'httparty'
require_relative 'flight_result'
require_relative 'iata_codes'

class MissingArguments < StandardError; end

module KiwiApi
  module Client
    KIWI_BASE_URL = 'https://api.skypicker.com'
    KIWI_FLIGHTS_PATH = '/flights'
    KIWI_PLACES_PATH = '/places'

    # https://api.skypicker.com/places?term=SVQ

    def self.search_flight(params = {})
      unless %i{origin destination date_from date_to}.all? { |required_param| !params[required_param].nil? }
        raise MissingArguments.new("The following params are required: origin, destination, date_from")
      end

      query_params = {
          flyFrom: params[:origin],
          to: params[:destination],
          dateFrom: params[:date_from],
          dateTo: params[:date_to] || params[:date_from],
          # flyDays: 5,
          # flyDaysType: 'departure',
          directFlights: 1,
          price_to: 150,
          curr: 'EUR',
          # daysInDestinationFrom: 2,
          # returnFlyDays: [0, 1],
          dtimefrom: '18:00',
          # sort: 'date',
          limit: params[:limit] || 5
      }

      response = HTTParty.get(KIWI_BASE_URL + KIWI_FLIGHTS_PATH, query: query_params, verify: false)

      if response.code == 200
        parsed_response = JSON.parse(response.body)
        # DateTime.strptime(result['dTime'].to_s, '%s')
        # airline_code = parsed_response['data'].first['airlines'].first

        parsed_response['data'].map do |flight_result_params|
          # departure_date_time = DateTime.strptime(flight['dTime'].to_s, '%s')
          # {
          #     # from: IATACodes.find_airport_by_code(flight['flyFrom']),
          #     from: flight['flyFrom'],
          #     # to: IATACodes.find_airport_by_code(flight['flyTo']),
          #     to: flight['flyTo'],
          #     city_to: flight['cityTo'],
          #     country: flight['countryTo'],
          #     price: flight['price'],
          #     departure_time: departure_date_time.strftime('%R'),
          #     departure_weekly_day: departure_date_time.strftime('%A'),
          #     departure_date: departure_date_time.strftime('%F'),
          #     airline: IATACodes.find_airline_by_code(flight['airlines'].first)
          # }
          FlightResult.new(flight_result_params)
        end
      else
        puts response.inspect
      end
    end
  end
end
