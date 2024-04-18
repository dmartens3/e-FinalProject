json.extract! sale, :id, :quantity, :cost, :tax, :product_id, :order_id, :created_at, :updated_at
json.url sale_url(sale, format: :json)
