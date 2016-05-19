require 'spec_helper'

describe MyApp do
  it "allows access to the index" do
    get "/"

    expect( last_response.status ).to eq 200
  end
end
