class Product < ApplicationRecord
    has_many :orders, dependent: :destroy
    enum :status, [:in_stock, :out_of_stock, :coming_soon]
    default_scope { where(is_active: true) }
end
