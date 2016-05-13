require "sinatra/base"

Tilt.register Tilt::ERBTemplate, "html.erb"

class ApplicationController < Sinatra::Base
  set :views, File.expand_path("../../views", __FILE__)
  set :public_folder, File.dirname(__FILE__) + '/../public/'
end
