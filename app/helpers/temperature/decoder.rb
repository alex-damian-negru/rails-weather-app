# frozen_string_literal: true

class Temperature
  class Decoder
    class << self
      def decode(base64)
        JSON.parse(Base64.strict_decode64(base64), symbolize_names: true)
      end

      def decodeable?(value)
        decode(value).then { true }
      rescue JSON::ParserError, ArgumentError
        false
      end
    end
  end
end
