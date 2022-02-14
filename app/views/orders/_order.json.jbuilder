json.extract! order, :id, :quantity, :total_price, :status, :product_id, :customer_id, :created_at, :updated_at
json.url order_url(order, format: :json)
