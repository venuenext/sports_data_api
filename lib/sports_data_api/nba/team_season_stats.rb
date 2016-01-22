require 'byebug'
module SportsDataApi
  module Nba
    class TeamSeasonStats
      attr_reader :season_id, :season_year, :season_type, :stats
      def initialize(xml)
        if xml.is_a? Nokogiri::XML::NodeSet
          byebug
          @season_id = xml.first['id']
          @season_year = xml.first['year'].to_i
          @season_type = xml.first['type'].to_sym
        end
      end
    end
  end
end
