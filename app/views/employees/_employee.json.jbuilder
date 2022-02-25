json.extract! employee, :id, :employee_name, :email, :password_digest, :gender, :hobbies, :mobile_number, :birth_date, :document, :created_at, :updated_at
json.url employee_url(employee, format: :json)
