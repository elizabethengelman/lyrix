require "sinatra/base"

Dir.glob("./app/{controllers,helpers}/*.rb").each do |file|
  require file
end

map("/search") { run SearchController }
map("/") { run MainController }

