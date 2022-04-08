json.extract! user, :id, :name, :email, :picture, :created_at, :updated_at
json.url user_url(user, format: :json)
