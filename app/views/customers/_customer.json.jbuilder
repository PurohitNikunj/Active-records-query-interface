json.extract! customer, :id, :fname, :lname, :email, :phoneno, :created_at, :updated_at
json.url customer_url(customer, format: :json)
