require "net/http"

class MusixClient
  MUSIX_ROOT_URL = "http://api.musixmatch.com/"
  VERSION = "/ws/1.1"
  ARTIST_SEARCH = "/artist.search?"
  TRACK_SEARCH = "/track.search?"
  API_KEY = "d123cc8eb0cb6c5348c5ba7073159052"

  def initialize
    uri = URI(MUSIX_ROOT_URL)
    @http = Net::HTTP.new uri.host, uri.port
  end

  def search(params)
    artist_name = params["artist-name"]
    track_title = params["track-title"]

    if artist_name && track_title
      search_by_artist_and_track(artist_name, track_title)
    elsif artist_name
      search_by_artist( params["artist-name"] )
    elsif track_title
      search_by_track_title( params["track-title"] )
    end
  end

  private

  def search_by_artist(artist_name)
    request = create_get_request(ARTIST_SEARCH, {"q_artist" => artist_name })
    @http.request(request)
  end


  def search_by_track_title(track_title)
    request = create_get_request(TRACK_SEARCH, {"q_track" => track_title })
    @http.request(request)
  end

  def search_by_artist_and_track(artist_name, track_title)
    request = create_get_request(TRACK_SEARCH, { "q_artist" => artist_name,
                                                 "q_track" => track_title })
    @http.request(request)
  end

  private

  def create_get_request(search_action, params)
    encoded_params = URI.encode_www_form(params.merge(
                                           { "apikey" => API_KEY}))
    url = VERSION + search_action + encoded_params
    Net::HTTP::Get.new url
  end
end
