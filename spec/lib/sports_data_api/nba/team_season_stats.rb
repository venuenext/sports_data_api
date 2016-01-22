require 'spec_helper'

describe SportsDataApi::Nba::TeamSeasonStats, vcr: {
    cassette_name: 'sports_data_api_nba_team_season_stats',
    record: :new_episodes,
    match_requests_on: [:host, :path]
} do
  before do
    SportsDataApi.set_key(:nba, api_key(:nba))
    SportsDataApi.set_access_level(:nba, 't')
  end
  let(:team_stats) { SportsDataApi::Nba.team_season_stats("583ed102-fb46-11e1-82cb-f4ce4684ea4c", 2014, "reg") }
  subject { team_stats }
  describe 'meta methods' do
    it { should respond_to :season_id }
    it { should respond_to :season_year }
    it { should respond_to :season_type }
    it { should respond_to :stats }
    it { subject.stats.kind_of?(Array).should be true }
  end
end
