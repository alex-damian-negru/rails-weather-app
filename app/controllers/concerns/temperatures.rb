# frozen_string_literal: true

module Temperatures
  extend ActiveSupport::Concern

  included do
    private

    def temperatures
      Temperature::TYPES.values.map do |type|
        if valid_cookie?(type)
          Temperature.new(decoded_cookie(type))
        else
          cookies.delete(type).then { Temperature.new(min: 0, max: 0, type: type) }
        end
      end
    end

    def decoded_cookie(key)
      Temperature::Decoder.decode(cookies[key])
    end

    def valid_cookie?(key)
      cookies[key].present? &&
        Temperature::Decoder.decodeable?(cookies[key]) &&
        Temperature::Decoder.decode(cookies[key]).keys.sort == Temperature.attributes.sort
    end
  end
end
