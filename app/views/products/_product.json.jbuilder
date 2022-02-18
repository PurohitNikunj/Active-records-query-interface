json.extract! product, :id, :title, :description, :price, :capacity, :is_active, :status, :created_at, :updated_at
json.url product_url(product, format: :json)
