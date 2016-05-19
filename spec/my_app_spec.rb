require 'spec_helper'

describe MyApp do
  let( :musix_client ) { double( :musix_client, search: nil) }
  let( :result_formatter ) { double( :result_formatter ) }

  before :each do
    allow( MusixClient ).to receive( :new ).and_return( musix_client )
    allow( ResultFormatter ).to receive( :new ).and_return( result_formatter )
    allow( result_formatter ).to receive( :format )
  end

  it "sends a request with the search params" do
    post "/search", "artist-name" => "The Beatles"

    expect( last_response.status ).to eq 200
    #expect( last_response.body ).to include( "The Beatles" )
  end

  it "creates a new MusixClient instance" do
    post "/search", "artist-name" => "The Doors"

    expect( MusixClient ).to have_received( :new )
  end

  it "calls MusixClient#search if there are search params" do
    post "/search", "artist-name" => "The Doors"

    expect( musix_client ).to have_received( :search ).
      with( "artist-name" => "The Doors" )
  end

  it "does not call MusixClient#search if there are no search params" do
    post "/search", "artist-name" => "", "track-title" => ""

    expect( musix_client ).not_to have_received( :search )
  end

  it "formats the MusixClient results" do
    response = double( :response )
    allow( musix_client ).to receive( :search ).
      and_return( response )

    post "/search", "artist-name" => "The Doors"

    expect( ResultFormatter ).to have_received( :new ).
      with( response )
    expect( result_formatter ).to have_received( :format )
  end
end
