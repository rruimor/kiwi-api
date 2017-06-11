require 'hashie'

module KiwiApi
  class FlightResult < Hashie::Mash
    def initialize(params = {})
      super(params.rubify_keys)
    end

    def departure_date_time
      @departure_date_time ||= Time.at(d_time)
    end
  end
end