require "spec_helper"

describe MusixClient do
  let(:musix_client) { MusixClient.new }
  let(:base_uri)     { URI(MusixClient::MUSIX_ROOT_URL) }
  let(:http)         { double(:http) }
  let(:get_request)  { double(:get_request) }
  let(:diana_ross_response) do
    "{\"message\":
      {\"body\":
        {\"artist_list\":
          [{\"artist\":
            {\"artist_name\":\"Diana Ross\"}
           }]
         }
      }}"
  end

  before :each do
    allow(Net::HTTP).to receive(:new).and_return(http)
    allow(Net::HTTP::Get).to receive(:new)
    allow(http).to receive(:request)
  end

  it "creates a new Net::HTTP connection with the base URI" do
    musix_client

    expect(Net::HTTP).to have_received(:new).
      with(base_uri.host, base_uri.port)
  end

  context "searching the API" do
    describe "#search" do
      it "constructs a GET request with the artist's name" do
        request_url = create_request_url MusixClient::ARTIST_SEARCH, "q_artist=Diana+Ross"

        musix_client.search("artist-name" => "Diana Ross")

        expect(Net::HTTP::Get).to have_received(:new).
          with(request_url)
      end

      it "constructs a GET request with the song title" do
        request_url = create_request_url MusixClient::TRACK_SEARCH, "q_track=back+to+december"

        musix_client.search("track-title" => "back to december")

        expect(Net::HTTP::Get).to have_received(:new).
          with(request_url)
      end

      it "contructs a GET request with the song title and artist name" do
        request_url = create_request_url MusixClient::TRACK_SEARCH,"q_artist=taylor+swift&q_track=back+to+december"

        musix_client.search("artist-name" => "taylor swift",
                            "track-title" => "back to december")

        expect(Net::HTTP::Get).to have_received(:new).
          with(request_url)
      end
    end
  end

  private

  def create_request_url(action, request_specific_string)
      MusixClient::VERSION + action +
        request_specific_string +
        "&apikey=#{MusixClient::API_KEY}"
  end
end
