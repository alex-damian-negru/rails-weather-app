# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Temperature, type: :model do
  it { is_expected.to validate_presence_of :min }
  it { is_expected.to validate_numericality_of(:min) }

  it { is_expected.to validate_presence_of :max }
  it { is_expected.to validate_numericality_of(:max).only_integer }
  it { is_expected.to validate_numericality_of(:max).is_greater_than_or_equal_to(-100) }
  it { is_expected.to validate_numericality_of(:max).is_less_than_or_equal_to(100) }

  it { is_expected.to validate_presence_of :type }
  it { is_expected.to validate_inclusion_of(:type).in_array Temperature::TYPES.values }

  describe '#to_encoded' do
    it 'encodes an instance of a temperature using its attributes' do
      value = described_class.new(min: 0, max: 0, type: Temperature::TYPES[:cold])
      expect(value.to_encoded).to eq 'eyJtaW4iOjAsIm1heCI6MCwidHlwZSI6ImNvbGQifQ=='
    end
  end
end
