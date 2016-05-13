describe ResultFormatter do
  before :each do
  end
  let( :artist_search_response ) do
    { "message" =>
       {"header"=>
         {"status_code" => 200},
       "body"=>
         {"artist-list" =>
            [{"artist" => { "artist_name" => "Wye Oak"}},
             {"artist" => { "artist_name" => "Beach House"}}]}}}.to_json
  end

  let( :response ) do
    { "message" =>
       {"header"=>
         {"status_code" => 200},
       "body"=> {"track_list" => [{"track" =>
                                    {"track_id" => 92588161,
                                     "track_name" =>"Tainted Love",
                                     "explicit" => 0,
                                     "has_lyrics" => 1,
                                     "album_name" => "Non-Stop Erotic Cabaret",
                                     "artist_id" => 610,
                                     "artist_name" => "Soft Cell",
                                     "album_coverart_350x350" =>
                                       "http://s.mxmcdn.net/images-storage/albums/2/9/2/5/0/6/32605292_350_350.jpg"}}]}}}.to_json

  end

  let( :formatter ) { described_class.new( response ) }

  it "parses the json response" do
    allow( JSON ).to receive( :parse )
    described_class.new( response )

    expect( JSON ).to have_received( :parse ).with( response )
  end

  it "parses a track.search response" do
    expect( formatter.track_list.first ).to include  "track_name" => "Tainted Love"
  end

  xit "gets the artist-list from the response body" do
    expect( formatter.artist_list ).
      to include "artist" => { "artist_name" => "Wye Oak" }
  end

  xit "gets all of the artists' names" do
    expect( formatter.matching_artist_names ).to include "Beach House"
  end
end
