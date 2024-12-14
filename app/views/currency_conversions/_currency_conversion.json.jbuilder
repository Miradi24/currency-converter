json.extract! currency_conversion, :id, :amount, :from, :to, :conversion_amount, :created_at, :updated_at
json.url currency_conversion_url(currency_conversion, format: :json)
