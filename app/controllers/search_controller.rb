class SearchController < ApplicationController
  get "/" do
    erb :search
  end

  post "/" do
    if !params.empty?
      musix_client = MusixClient.new
      musix_client.search( params )

      erb :search
    else
      flash[:notice] = "Please enter either an artist name or track title"
    end
  end
end
