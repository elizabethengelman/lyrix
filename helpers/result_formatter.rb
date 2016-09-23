require 'json'

class ResultFormatter
  attr_reader :parsed_response
  FIELDS_TO_DISPLAY = [ "track_name", "artist_name", "explicit"]

  def initialize(response)
    @parsed_response = JSON.parse(response.body)
  end

  def search_results_table
    build_results_table
  end

  def parsed_results
    track_list.map do |track_listing|
      track_listing["track"].select do |key, value|
        FIELDS_TO_DISPLAY.include?(key)
      end
    end
  end

  def track_list
    parsed_response.fetch("message").
      fetch("body").fetch("track_list")
  end
end
