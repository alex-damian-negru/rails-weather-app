# frozen_string_literal: true

class ZipCodeService
  class << self
    def valid?(zip_code)
      ValidatesZipcode.valid? zip_code, 'UK'
    end
  end
end
