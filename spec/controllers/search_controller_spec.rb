require 'spec_helper'

describe SearchController do
  let( :musix_client ) { double( :musix_client, search: nil) }

  before :each do
    allow( MusixClient ).to receive( :new ).and_return( musix_client )
  end

  it "sends a request with the search params" do
    post "/", "artist-name" => "The Beatles"

    expect( last_response.status ).to eq 200
    expect( last_response.body ).to include( "The Beatles" )
 end

  it "creates a new MusixClient instance" do
    post "/", "artist-name" => "The Doors"

    expect( MusixClient ).to have_received( :new )
  end

  it "calls MusixClient#search if there are search params" do
    post "/", "artist-name" => "The Doors"

    expect( musix_client ).to have_received( :search ).
      with( "artist-name" => "The Doors" )
  end

  it "does not call MusixClient#search if there are no search params" do
    post "/"

    expect( musix_client ).not_to have_received( :search )
  end
end
