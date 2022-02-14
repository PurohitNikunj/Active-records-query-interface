class Order < ApplicationRecord
  belongs_to :product
  belongs_to :customer
  enum :status, [:booked, :cancelled]
  validates :status, presence: true

  def product
    Product.unscoped { super }
  end
end
