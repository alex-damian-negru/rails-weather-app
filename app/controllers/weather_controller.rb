# frozen_string_literal: true

class WeatherController < ApplicationController
  include Temperatures

  def show
    @temperatures = temperatures
    weather = Weather.new(zip_code: params[:zip_code])

    if weather.valid?
      @weather = WeatherService.forecast_for_today(params[:zip_code]).then do |forecast|
        ::Weather.build(forecast, temperatures)
      end
    else
      @errors = weather.errors.messages_for(:zip_code)
    end
  end
end
