require 'hashie'
require_relative 'helpers/core_helper'

module KiwiApi
  class FlightResult < Hashie::Mash
    def initialize(params = {})
      super(CoreHelper.rubify_keys(params))
    end

    def departure_date_time
      @departure_date_time ||= Time.at(d_time)
    end
  end
end
