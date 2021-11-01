# frozen_string_literal: true

class ZipCode
  class << self
    def valid?(zip_code)
      ValidatesZipcode.valid? zip_code, 'UK'
    end
  end
end
