# frozen_string_literal: true

class Temperature < Model
  TYPES = %w[cold warm hot].freeze

  attr_accessor :min, :max, :type

  validates :min, :max, :type, presence: true
  validates :type, inclusion: { in: TYPES }
  validates :min, numericality: { less_than_or_equal_to: :max, message: I18n.t('temperatures.errors.min_over_max') }
  validates :min, :max, numericality: { only_integer: true, greater_than_or_equal_to: -100, less_than_or_equal_to: 100 }

  def to_encoded = Temperature::Encoder.encode({ min: min, max: max, type: type })
end
