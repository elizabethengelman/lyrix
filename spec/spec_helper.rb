require "rack/test"
require "rspec"
require File.join(File.dirname(__FILE__), "../app")
Dir[File.join(File.dirname(__FILE__), "../app/*.rb")].each {|file| require file}


ENV["RACK_ENV"] = "test"

module RSpecMixin
  include Rack::Test::Methods
  def app
    described_class
  end
end

RSpec.configure { |config| config.include RSpecMixin }
