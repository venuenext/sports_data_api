require 'byebug'
require 'looksee'
module SportsDataApi
  module Nba
    class TeamSeasonStats
      attr_reader :season_id, :season_year, :season_type, :team_id, :totals,
                  :averages

      def initialize(json)
        @season_id = json['season']['id']
        @season_year = json['season']['year'].to_i
        @season_type = json['season']['type'].to_sym
        @team_id = json['id']

        @totals = json['own_record']['total']
        @averages = json['own_record']['average']
      end
    end
  end
end
