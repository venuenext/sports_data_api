module SportsDataApi
  module NbaImages

    class Exception < ::Exception
    end

    SPORT = :nba_images
    DIR = File.join(File.dirname(__FILE__), SPORT.to_s)
    BASE_URL = 'https://api.sportradar.us/nba-images-%{access_level}%{version}'
    DEFAULT_VERSION = 2

    autoload :Asset, File.join(DIR, 'asset')
    autoload :HeadshotsAssets, File.join(DIR, 'headshots_assets')

    ##
    # Fetches image URLs for NBA player headshots
    def self.headshots_assets(version = DEFAULT_VERSION)
      response = self.response_xml(version, "/usat/players/headshots/manifests/all_assets.xml")
      return HeadshotsAssets.new(response.xpath('/'))
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
