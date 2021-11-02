# frozen_string_literal: true

class TemperaturesController < ApplicationController
  include Concerns::Temperatures

  def index
    @temperatures = temperatures
  end

  def upsert
    @temperatures = params.require(:temperatures).map { Temperature.new _1.permit(:type, :min, :max) }

    if @temperatures.all?(&:valid?)
      @temperatures.each { cookies[_1.type] = _1.to_encoded }
    else
      @errors = @temperatures.map(&:errors).flat_map(&:full_messages)
    end
  end
end
