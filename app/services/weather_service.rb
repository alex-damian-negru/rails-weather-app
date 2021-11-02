# frozen_string_literal: true

class WeatherService
  ENDPOINT = 'http://api.weatherapi.com/v1'

  class << self
    def forecast(query)
      URI(ENDPOINT)
        .tap { _1.path += '/forecast.json' }
        .tap { _1.query = { key: ENV['WEATHER_API_KEY'], q: query }.to_query }
        .then { ::Net::HTTP.get(_1) }
        .then { JSON.parse(_1, symbolize_names: true) }
    end

    def forecast_for_today(...)
      forecast(...)
        .dig(:forecast, :forecastday, 0, :day)
        &.reject { |_key, value| value.blank? }
        .then { _1 || { status: :unavailable } }
    end
  end
end
