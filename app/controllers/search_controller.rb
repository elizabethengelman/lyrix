class SearchController < ApplicationController
  get "/" do
    erb :search
  end

  post "/" do
    @params = params
    if !empty_params?( params )
      musix_client = MusixClient.new
      response = musix_client.search( params )
      @results = ResultFormatter.new( response ).format

      erb :search
    else
      erb :error
    end
  end

  private

  def empty_params?( params )
    params.all? { |key, value| value.empty? }
  end
end
