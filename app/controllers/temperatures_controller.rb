# frozen_string_literal: true

class TemperaturesController < ApplicationController
  def index
    @temperatures = Temperature::TYPES.map do |type|
      cookie?(type) ? Temperature.new(decoded_cookie(type)) : Temperature.new(min: 0, max: 0, type: type)
    end
  end

  def upsert
    @temperatures =
      params
      .require(:temperatures)
      .map { _1.permit(:type, :min, :max) }
      .map { Temperature.new(_1) }

    if @temperatures.all?(&:valid?)
      @temperatures.each { cookies[_1.type] = _1.to_encoded if cookies[_1.type].blank? || changed?(_1) }
    else
      @errors = @temperatures.map(&:errors).flat_map(&:full_messages)
    end
  end

  private

  def changed?(temperature)
    decoded_cookie(temperature.type) != temperature
  end

  def decoded_cookie(key)
    Temperature::Decoder.decode(cookies[key])
  end

  def cookie?(key)
    cookies[key].present?
  end
end
