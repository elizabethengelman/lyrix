require "sinatra/base"

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
      erb :search
    else
      erb :error
    end
  end
end



