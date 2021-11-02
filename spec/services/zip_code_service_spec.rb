# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ZipCodeService do
  subject(:service) { described_class }

  describe '.valid?' do
    subject(:valid?) { service.valid?(zip_code) }

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
