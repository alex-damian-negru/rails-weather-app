# frozen_string_literal: true

class TemperaturesController < ApplicationController
  def index
    @temperatures = Temperature::TYPES.values.map do |type|
      if valid_cookie?(type)
        Temperature.new(decoded_cookie(type))
      else
        cookies.delete(type).then { Temperature.new(min: 0, max: 0, type: type) }
      end
    end
  end

  def upsert
    @temperatures = params.require(:temperatures).map { Temperature.new _1.permit(:type, :min, :max) }

    if @temperatures.all?(&:valid?)
      @temperatures.each { cookies[_1.type] = _1.to_encoded }
    else
      @errors = @temperatures.map(&:errors).flat_map(&:full_messages)
    end
  end

  private

  def decoded_cookie(key)
    Temperature::Decoder.decode(cookies[key])
  end

  def valid_cookie?(key)
    cookies[key].present? &&
      Temperature::Decoder.decodeable?(cookies[key]) &&
      Temperature::Decoder.decode(cookies[key]).keys.sort == Temperature.attributes.sort
  end
end
