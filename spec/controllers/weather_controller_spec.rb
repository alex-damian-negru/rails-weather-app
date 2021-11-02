# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WeatherController, :vcr, type: :controller do
  describe '#show' do
    subject(:show) { get :show, params: { zip_code: zip_code } }

    context 'with a valid zip code' do
      let(:zip_code) { 'SW1A 2AA' }

      around do |example|
        VCR.use_cassette('services/weather_service/success', match_requests_on: [:method]) { example.run }
      end

      it 'fetches the weather' do
        show.then { expect(assigns(:weather)).to be_present }
      end

      it 'has no errors' do
        show.then { expect(assigns(:errors)).to be_blank }
      end
    end

    context 'with an invalid zip code' do
      let(:zip_code) { 'What do you call an exploding monkey? Baboom.' }

      it 'fetches the weather' do
        show.then { expect(assigns(:weather)).to be_blank }
      end

      it 'has no errors' do
        show.then { expect(assigns(:errors)).to be_present }
      end
    end
  end
end
