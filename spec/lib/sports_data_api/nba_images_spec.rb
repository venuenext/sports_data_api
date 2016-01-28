require 'spec_helper'

describe SportsDataApi::NbaImages, vcr: {
    cassette_name: 'sports_data_api_nba_images',
    record: :new_episodes,
    match_requests_on: [:uri]
} do

  context 'invalid API key' do
    before(:each) do
      SportsDataApi.set_key(:nba_images, 'invalid_key')
      SportsDataApi.set_access_level(:nba_images, 't')
    end
    describe '.headshots_assets' do
      it { expect { subject.headshots_assets }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'no response from the api' do
    before(:each) { stub_request(:any, /api\.sportradar\.us.*/).to_timeout }
    describe '.headshots_assets' do
      it { expect { subject.headshots_assets }.to raise_error(SportsDataApi::Exception) }
    end
  end

  context 'with a valid API key' do
    let(:headshots_assets_url) { 'https://api.sportradar.us/nba-images-t2/usat/players/headshots/manifests/all_assets.xml' }

    before(:each) do
      SportsDataApi.set_key(:nba_images, api_key(:nba_images))
      SportsDataApi.set_access_level(:nba_images, 't')
    end

    describe '.headshots_assets' do
      it 'creates a valid Sportradar url' do
        params = { params: { api_key: SportsDataApi.key(:nba_images) } }
        RestClient.should_receive(:get).with(headshots_assets_url, params).and_return('{}')
        subject.headshots_assets
      end
      it 'returns an xml document' do
        expect(subject.headshots_assets.class).to eq SportsDataApi::NbaImages::HeadshotsAssets
      end
    end
  end
end
