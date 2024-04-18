json.extract! order, :id, :status_id, :user_id, :total, :created_at, :updated_at
json.url order_url(order, format: :json)
