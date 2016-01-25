module SportsDataApi
  module NbaImages

    class Exception < ::Exception
    end

    DIR = File.join(File.dirname(__FILE__), 'nba')
    BASE_URL = 'https://api.sportradar.us/nba-images-%{access_level}%{version}'
    DEFAULT_VERSION = 2
    SPORT = :nba_images

    ##
    # Fetches manifests for NBA player headshots
    def self.headshots_manifests(version = DEFAULT_VERSION)
      response = self.response_xml(version, "/usat/players/headshots/manifests/all_assets.xml")

      #return Games.new(response.xpath('league/daily-schedule'))

      #return Teams.new(response.xpath('/league'))
    end

    private
    def self.response_xml(version, url)
      Nokogiri::XML(response_generic(version, url).to_s).remove_namespaces!
    end

    def self.response_json(version, url)
      JSON.parse(response_generic(version, url).to_s)
    end

    def self.response_generic(version, url)
      base_url = BASE_URL % { access_level: SportsDataApi.access_level(SPORT), version: version }
      SportsDataApi.generic_request("#{base_url}#{url}", SPORT)
    end
  end
end
