module KiwiApi
  class FlightResult
    attr_reader :origin, :destination, :price, :departure_date_time, :arrival_date_time, :airline

    def initialize(params = {})
      @origin = params['flyFrom']
      @destination = params['flyTo']
      @price = params['price']
      @departure_date_time = DateTime.strptime(params['dTime'].to_s, '%s') if params['dTime']
      @arrival_date_time = DateTime.strptime(params['aTime'].to_s, '%s') if params['aTime']
      @airline = params['airlines'].first if params['airlines']
    end

    def departure_time
      departure_date_time.strftime('%R')
    end

    def departure_weekly_day
      departure_date_time.strftime('%A')
    end

    def departure_date
      departure_date_time.strftime('%F')
    end
  end
end