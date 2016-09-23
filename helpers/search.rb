class Search
  def self.call(search_params)
    if !empty_params?(search_params)
      musix_client = MusixClient.new
      response = musix_client.search(search_params)
      ResultFormatter.new(response).search_results_table
    end
  end

  private

  def self.empty_params?(params)
    params.all? { |key, value| value.empty? }
  end
end
