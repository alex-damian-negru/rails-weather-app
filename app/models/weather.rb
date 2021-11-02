# frozen_string_literal: true

class Weather < Model
  attr_accessor :temperature, :label, :zip_code

  validates :zip_code, zipcode: { country_code: :uk }

  class << self
    def build(forecast, user_temperatures)
      new(**{}.tap do |hash|
        hash[:temperature] = forecast[:maxtemp_c]
        hash[:label] = for_temperatures(hash[:temperature], user_temperatures)
      end)
    end

    def for_temperatures(temperature, user_temperatures)
      type = user_temperatures.select { (_1.min.to_i..._1.max.to_i).cover? temperature }.first&.type

      if type.blank?
        I18n.t('temperatures.formatted.unknown',
               reason: temperature ? "#{temperature}°C" : I18n.t('notices.weather_unavailable'))
      else
        I18n.t("temperatures.formatted.#{type}", temperature: temperature)
      end
    end
  end
end
