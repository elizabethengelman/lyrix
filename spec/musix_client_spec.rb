require "spec_helper"

describe MusixClient do
  let(:host)        { "api.musixmatch.com" }
  let(:port)        { "port" }
  let(:request_uri) { "/ws/1.1/" }
  let(:song_id)     { "123" }


  let(:uri) { double(:uri, host: host, port: port, request_uri: request_uri) }
  let(:musix_client) { MusixClient.new }

  before :each do
    allow(Net::HTTP).to receive(:new)
    allow(URI).to receive(:parse).and_return(uri)
    allow(Net::HTTP::Get).to receive(:new)
  end

  it "parses the root MusixMatch url" do
    musix_client

    expect(URI).to have_received(:parse)
      .with( MusixClient::MUSIX_ROOT_URL)
  end

  it "creates a new Net::HTTP instance with the host and port" do
    musix_client

    expect(Net::HTTP).to have_received(:new)
      .with(host, port)
  end


  describe "#get request to MusixMatch" do
    it "creates a Net::HTTP::Get instance with the apikey and song id" do
      musix_client.get_song(song_id)

      expect(Net::HTTP::Get).to have_received(:new)
        .with(request_uri + song_id + "?apikey=#{MusixClient::API_KEY}")
    end
  end
end
