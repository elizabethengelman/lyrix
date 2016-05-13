require 'json'

class ResultFormatter
  attr_reader :parsed_response

  def initialize( response )
    @parsed_response = JSON.parse( response )
  end

  def artist_list
    parsed_response.fetch("message").fetch("body").fetch("artist-list")
  end

  def track_list
    parsed_response.fetch("message").
      fetch("body").fetch("track_list")
  end

  def matching_artist_names
    artist_list.map do |artist_record|
      artist_record.fetch( "artist" ).fetch( "artist_name" )
    end
  end
end
