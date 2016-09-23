require "sinatra/base"
require 'json'

Tilt.register Tilt::ERBTemplate, "html.erb"

Dir.glob("./helpers/*.rb").each do |file|
  require file
end

class MyApp < Sinatra::Base
  get "/" do
    erb :index
  end

  get "/search" do
    erb :search
  end

  post "/search" do
    if @results = Search.call( params )
      { :results => @results, :status => "success" }.to_json
    else
      { :status => "error" }.to_json
    end
  end
end



