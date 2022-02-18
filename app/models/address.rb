class Address < ApplicationRecord
    belongs_to :user
    validates :address, presence: true

    def user
        User.unscoped { super }
    end
end
