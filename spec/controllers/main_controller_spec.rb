require 'spec_helper'

describe MainController do
  it "allows access to the index" do
    get "/"

    expect( last_response.status ).to eq 200
  end
end
