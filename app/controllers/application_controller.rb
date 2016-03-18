require "sinatra/base"
require "rack-flash"

Tilt.register Tilt::ERBTemplate, "html.erb"

class ApplicationController < Sinatra::Base
  set :views, File.expand_path("../../views", __FILE__)
end
