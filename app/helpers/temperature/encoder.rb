# frozen_string_literal: true

class Temperature
  class Encoder
    class << self
      def encode(params)
        Base64.strict_encode64(params.to_json)
      end
    end
  end
end
