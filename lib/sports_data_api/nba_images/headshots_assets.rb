module SportsDataApi
  module NbaImages
    class HeadshotsAssets
      include Enumerable
      attr_reader :assets, :date

      def initialize(xml)
        debugger
        @date = xml.first['date']

        @assets = xml.xpath("assets/game").map do |game_xml|
          Game.new(date: @date, xml: game_xml)
        end
      end

      def each &block
        @assets.each do |game|
          if block_given?
            block.call game
          else
            yield game
          end
        end
      end
    end
  end
end
