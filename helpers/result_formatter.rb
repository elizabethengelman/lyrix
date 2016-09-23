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

  def convert_explicit_lyric_flag(flag)
    flag == 1
  end

  def build_results_table
    table = "<table> <th>Artist</th> <th>Song Name</th> <th>Explicit Lyrics?</th>"
    parsed_results.each do |result|
      table += "<tr><td>#{result["artist_name"]}</td>" +
               "<td>#{result["track_name"]}</td>" +
               "<td>#{convert_explicit_lyric_flag(result["explicit"])}</td></tr>"
    end
    table
  end

  def track_list
    parsed_response.fetch("message").
      fetch("body").fetch("track_list")
  end
end
