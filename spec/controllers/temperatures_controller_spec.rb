# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TemperaturesController, type: :controller do
  describe '#index' do
    subject(:index) { get :index }

    let(:temperatures) { assigns(:temperatures) }

    it 'fetches temperature objects' do
      index.then { expect(temperatures).to all be_a Temperature }
    end

    it 'fetches as many objects as there are types' do
      index.then { expect(temperatures.count).to eq Temperature::TYPES.count }
    end

    context 'when the temperatures have been defined' do
      before do
        Temperature::TYPES.each_key do |type|
          cookies[type] = Base64.strict_encode64 attributes_for(:temperature, type).to_json
        end
      end

      it 'uses the already defined values' do
        values = [
          { type: 'cold', min: 0, max: 18 },
          { type: 'warm', min: 19, max: 28 },
          { type: 'hot', min: 29, max: 50 }
        ]

        index.then { expect(temperatures.map(&:to_h)).to eq values }
      end
    end

    context 'when the temperatures have not been defined' do
      it 'uses the default values' do
        values = [
          { type: 'cold', min: 0, max: 0 },
          { type: 'warm', min: 0, max: 0 },
          { type: 'hot', min: 0, max: 0 }
        ]

        index.then { expect(temperatures.map(&:to_h)).to eq values }
      end
    end

    context 'when the cookies have been tampered with' do
      shared_examples 'an invalid cookies handler' do
        it 'deletes the affected cookies' do
          index.then do
            expect(cookies[:warm]).to be_blank
            expect(cookies[:cold]).to be_present
            expect(cookies[:hot]).to be_present
          end
        end

        it 'uses the default values' do
          values = [
            { type: 'cold', min: 0, max: 18 },
            { type: 'warm', min: 0, max: 0 },
            { type: 'hot', min: 29, max: 50 }
          ]

          index.then { expect(temperatures.map(&:to_h)).to eq values }
        end
      end

      context 'with non-decodeable values' do
        before do
          cookies[:cold] = Base64.strict_encode64 attributes_for(:temperature, :cold).to_json
          cookies[:warm] = 'invalid'
          cookies[:hot] = Base64.strict_encode64 attributes_for(:temperature, :hot).to_json
        end

        it_behaves_like 'an invalid cookies handler'
      end

      context 'with decodeable, but invalid values' do
        before do
          cookies[:cold] = Base64.strict_encode64 attributes_for(:temperature, :cold).to_json
          cookies[:warm] = Base64.strict_encode64({ key: :invalid }.to_json)
          cookies[:hot] = Base64.strict_encode64 attributes_for(:temperature, :hot).to_json
        end

        it_behaves_like 'an invalid cookies handler'
      end
    end
  end

  describe '#upsert' do
    subject(:upsert) { post(:upsert, params: params) }

    context 'with valid temperatures' do
      let(:params) do
        {
          temperatures: [
            { type: Temperature::TYPES[:cold], min: -5, max: 0 },
            { type: Temperature::TYPES[:warm], min: 1, max: 5 },
            { type: Temperature::TYPES[:hot], min: 6, max: 10 }
          ]
        }
      end

      it 'persists the new definitions' do
        upsert.then do
          expect(cookies[:cold]).to be_present
          expect(cookies[:warm]).to be_present
          expect(cookies[:hot]).to be_present
        end
      end

      it 'has no errors' do
        upsert.then { expect(assigns(:errors)).to be_blank }
      end
    end

    context 'with invalid temperatures' do
      let(:params) do
        {
          temperatures: [
            { type: Temperature::TYPES[:cold], min: -5, max: 10 },
            { type: Temperature::TYPES[:warm], min: 1000, max: 5 },
            { type: 'permafrost', min: 6, max: 10 }
          ]
        }
      end

      it 'does not alter the temperatures' do
        expect { upsert }.not_to(change { cookies[:cold] })
        expect { upsert }.not_to(change { cookies[:warm] })
        expect { upsert }.not_to(change { cookies[:hot] })
      end

      it 'has errors' do
        upsert.then { expect(assigns(:errors)).to be_present }
      end
    end
  end
end
