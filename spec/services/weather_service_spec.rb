# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherService, :vcr do
  subject(:service) { described_class }

  describe '.forecast' do
    subject(:forecast) { service.forecast(query) }

    let(:query) { 'SW1' }

    context 'with an invalid API key' do
      around do |example|
        VCR.use_cassette('services/weather_service/invalid_api_key', match_requests_on: [:method]) { example.run }
      end

      it { is_expected.to eq(error: { code: 2006, message: 'API key is invalid.' }) }
    end

    context 'with an invalid query' do
      around do |example|
        VCR.use_cassette('services/weather_service/invalid_query', match_requests_on: [:method]) { example.run }
      end

      let(:query) { 'laksjflaslkfdasljgoasjgoiwashogoishg' }

      it { is_expected.to eq(error: { code: 1006, message: 'No matching location found.' }) }
    end

    context 'with a successful query' do
      around do |example|
        VCR.use_cassette('services/weather_service/success', match_requests_on: [:method]) { example.run }
      end

      it { is_expected.not_to include(:error) }
    end
  end

  describe '.forecast_for_today' do
    subject(:forecast_for_today) { service.forecast_for_today('SW1') }

    context 'when the response is successful' do
      around do |example|
        VCR.use_cassette('services/weather_service/success', match_requests_on: [:method]) { example.run }
      end

      it { is_expected.to eq(maxtemp_c: 12.6) }
    end

    context 'when the response has errors' do
      around do |example|
        VCR.use_cassette('services/weather_service/invalid_query', match_requests_on: [:method]) { example.run }
      end

      it { is_expected.to eq(status: :unavailable) }
    end
  end
end
