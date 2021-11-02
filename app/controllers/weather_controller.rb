# frozen_string_literal: true

class WeatherController < ApplicationController
  include Concerns::Temperatures

  def show
    @temperatures = temperatures
  end
end
