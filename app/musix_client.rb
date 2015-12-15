require "net/http"
class MusixClient
  MUSIX_ROOT_URL = "http://api.musixmatch.com/ws/1.1/"
  API_KEY = "key"
  attr_reader :uri

  def initialize
    #only want to create one Net::HTTP instance so we can re-use the connection?
    @uri = URI.parse(MUSIX_ROOT_URL)

    http = Net::HTTP.new(uri.host, uri.port)
  end

  def get_song(song_id)
    Net::HTTP::Get.new(create_request_uri(song_id))
  end

  def create_request_uri(song_id)
    encoded_api_key = URI.encode_www_form({"apikey" => API_KEY})
    uri.request_uri + song_id + "?" + encoded_api_key
  end



end
