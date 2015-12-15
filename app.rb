require "sinatra"

Tilt.register Tilt::ERBTemplate, "html.erb"

class LindasLyricChecker < Sinatra::Base
  get "/" do
    erb :index
  end
end
