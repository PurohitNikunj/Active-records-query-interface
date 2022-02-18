class Category < ApplicationRecord
    has_many :events, dependent: :destroy
    enum :category_type, [:music, :sports, :visual_art, :film]
end
