require 'yaml'

module IataCodes
  IATA_URL = 'https://iatacodes.org/api/v6'
  AIRLINES_PATH = '/airlines'
  AIRPORTS_PATH = '/airports'
  @@airlines = {}
  @@airports = {}
  # Example request
  # https://iatacodes.org/api/v6/airlines?api_key=YOUR_API_KEY&code=FR

  def self.find_airline_by_code(code)
    return @@airlines[code] if @@airlines[code]

    uri = URI(IATA_URL + AIRLINES_PATH)

    params = { code: code, api_key: api_key}

    response = HTTParty.get(uri, query: params, verify: false)

    if response.code == 200
      parsed_response = JSON.parse(response.body)
      @@airlines[code] = parsed_response['response'].first['name']
    else
      puts "Something fuckeeeedddd"
    end
  end

  def self.find_airport_by_code(code)
    return @@airports[code] if @@airports[code]

    uri = URI(IATA_URL + AIRPORTS_PATH)

    params = { code: code, api_key: API_KEY }

    response = HTTParty.get(uri, query: params, verify: false)


    if response.code == 200
      parsed_response = JSON.parse(response.body)
      @@airports[code] = parsed_response['response'].first['name']
    else
      puts "Something fuckeeeedddd"
    end
  end

  def self.api_key
    config['iata_codes_api_key']
  end

  def self.config
    @config ||= YAML.load_file('config.yaml')
  end
end