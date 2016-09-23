require "spec_helper"

describe ResultFormatter do

  let( :response )  { double( :response, body: response_body ) }
  let( :response_body ) do
    { "message" =>
       { "header"=>
           { "status_code" => 200},
         "body"=>
           { "track_list" => [{ "track"=>
                                { "track_id"=>20032289,
                                  "track_name"=>"Back to December",
                                  "track_rating"=>100,
                                  "track_listength"=>296,
                                  "explicit"=>0,
                                  "has_lyrics"=>1,
                                  "lyrics_id"=>14094468,
                                  "album_name"=>"Taylor Swift Karaoke: Speak Now",
                                  "artist_id"=>259675,
                                  "artist_name"=>"Taylor Swift" }}]}}}.to_json
  end

  let( :formatter ) { described_class.new( response ) }

  it "extracts the track-list from the response" do
    track_list = formatter.track_list
    expect( track_list.first["track"] ).
      to include  "track_name" => "Back to December"
  end

  it "creates a list of track names, artists and explicit lyric flag" do
    expected = [{ "track_name" => "Back to December",
                  "explicit" => 0,
                  "artist_name"=> "Taylor Swift"}]
    expect( formatter.parsed_results ).to eq expected
  end

  it "converts explicit lyric flag to true or false" do
    expect(formatter.convert_explicit_lyric_flag(0)).to eq false
    expect(formatter.convert_explicit_lyric_flag(1)).to eq true
  end

end
#  xit "parses the json response" do
#    allow( JSON ).to receive( :parse )
#    described_class.new( response )
#
#    expect( JSON ).to have_received( :parse ).with( response )
#  end
#
#  context "when searching with artist name AND track title" do
#    xit "parses a response" do
#      formatter = described_class.new( response )
#      expect( formatter.format ).to include( {"artist-name" => "Soft Cell",
#                                              "track-title" => "Tainted Love", 
#                                              "explicit?" => "false"} )
#    end
#  end

#  xit "gets the artist-list from the response body" do
#    expect( formatter.artist_list ).
#      to include "artist" => { "artist_name" => "Wye Oak" }
#  end

  #xit "gets all of the artists' names" do
  #  expect( formatter.matching_artist_names ).to include "Beach House"
  #end
#
#  let( :artist_search_response ) do
#    { "message" =>
#       {"header"=>
#         {"status_code" => 200},
#       "body"=>
#         {"artist-list" =>
#            [{"artist" => { "artist_name" => "Wye Oak"}},
#             {"artist" => { "artist_name" => "Beach House"}}]}}}.to_json
#  end
#
#  let( :response ) do
#    { "message" =>
#       {"header"=>
#         {"status_code" => 200},
#       "body"=> {"track_list" => [{"track" =>
#                                    {"track_id" => 92588161,
#                                     "track_name" =>"Tainted Love",
#                                     "explicit" => 0,
#                                     "has_lyrics" => 1,
#                                     "album_name" => "Non-Stop Erotic Cabaret",
#                                     "artist_id" => 610,
#                                     "artist_name" => "Soft Cell",
#                                     "album_coverart_350x350" =>
#                                       "http://s.mxmcdn.net/images-storage/albums/2/9/2/5/0/6/32605292_350_350.jpg"}}]}}}.to_json
#
