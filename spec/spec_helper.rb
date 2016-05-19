require "rack/test"
require "rspec"

Dir[File.join(File.dirname(__FILE__), "../helpers/*.rb")].each { |file| require file }
require Dir[File.join(File.dirname(__FILE__), "../my_app.rb")].first

ENV["RACK_ENV"] = "test"

module RSpecMixin
  include Rack::Test::Methods
  def app
    described_class
  end
end

RSpec.configure { |config| config.include RSpecMixin }
