# frozen_string_literal: true

class Temperature < Model
  TYPES = %w[cold warm hot]

  attr_accessor :min, :max, :type
end
