require "spec_helper"

describe LindasLyricChecker do
  context "index" do
    it "allows access to the home page" do
      get "/"

      expect(last_response.status).to eq(200)
    end

    it "returns a 404 if the pages does not exist" do
      get "/does-not-exist"

      expect(last_response.status).to eq(404)
    end
  end
end
