json.array!(@parses) do |parse|
  json.extract! parse, :id, :purchaser_name, :item_description, :item_price, :purchase_count, :merchant_address, :merchant_name
  json.url parse_url(parse, format: :json)
end
