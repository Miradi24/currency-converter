require "net/http"
require "json"

module CurrencyConverter
  def get_currencies
    url = "https://v6.exchangerate-api.com/v6/7045b7fe38d52ab977cb614b/latest/USD"
    uri = URI(url)

    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    # Get currency strings
    data["conversion_rates"].keys
  end
end
