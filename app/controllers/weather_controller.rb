# frozen_string_literal: true

class WeatherController < ApplicationController
  def show
    @temperature = Temperature.new
  end
end
