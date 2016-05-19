require 'json'

class ResultFormatter
  attr_reader :parsed_response
  FIELDS_TO_DISPLAY = [ "track_name", "artist_name", "explicit"]

  def initialize( response )
    # turn the result into a class?
    @parsed_response = JSON.parse( response.body )
  end

  def format
    track_list.map do |track_listing|
      track_listing["track"].select{ |key, value| FIELDS_TO_DISPLAY.include?( key ) }
    end
  end

  def track_list
    parsed_response.fetch("message").
      fetch("body").fetch("track_list")
  end
end
