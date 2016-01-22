module SportsDataApi
  module Nba
    class TeamSeasonStats
      attr_reader :season_id, :season_year, :season_type, :team_id, :totals,
                  :averages

      def initialize(json)
        @team_id = json.fetch('id', nil)

        @season_id = json.fetch('season', {}).fetch('id', nil)
        @season_year = json.fetch('season', {}).fetch('year', nil)
        @season_type = json.fetch('season', {}).fetch('type', 'nil').to_sym

        @totals = json.fetch('own_record', {}).fetch('total', nil)
        @averages = json.fetch('own_record', {}).fetch('average', nil)
      end
    end
  end
end
