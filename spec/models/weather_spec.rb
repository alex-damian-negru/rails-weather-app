# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Weather, type: :model do
  subject(:model) { described_class }

  context 'when validating' do
    subject(:valid?) { model.new(zip_code: zip_code).valid? }

    context 'for the zip code' do
      context 'for an UK zip code' do
        let(:zip_code) { 'SW1A 2AA' }

        it { is_expected.to be_truthy }
      end

      context 'for a non-UK zip code' do
        let(:zip_code) { "Rick Roll'd" }

        it { is_expected.to be_falsey }
      end
    end
  end

  describe '.build' do
    subject(:weather) { described_class.build(forecast, user_temperatures) }

    let(:user_temperatures) { [build(:temperature, :cold), build(:temperature, :warm), build(:temperature, :hot)] }

    context 'with a valid forecast' do
      context 'when the temperature is within the user defined ranges' do
        let(:forecast) { { maxtemp_c: 42.0 } }

        its(:temperature) { is_expected.to eq 42 }
        its(:label) { is_expected.to eq 'Hot (Max 42.0°C)' }
      end

      context 'when the temperature is outside the user defined ranges' do
        let(:forecast) { { maxtemp_c: -999.0 } }

        its(:temperature) { is_expected.to eq(-999.0) }
        its(:label) { is_expected.to eq 'Unknown (-999.0°C)' }
      end

      context 'when the temperature is within two overlapping intervals' do
        let(:forecast) { { maxtemp_c: 42.0 } }
        let(:user_temperatures) do
          [
            build(:temperature, :cold),
            build(:temperature, :warm, min: 10, max: 50),
            build(:temperature, :hot, min: 20, max: 9001)
          ]
        end

        it 'picks the first of the intervals' do
          expect(weather.label).to eq 'Warm (Max 42.0°C)'
        end
      end
    end

    context 'with an invalid forecast' do
      let(:forecast) { { status: :unavailable } }

      its(:temperature) { is_expected.to be_blank }
      its(:label) { is_expected.to eq 'Unknown (Weather service is unavailable. Please try again later)' }
    end
  end
end
