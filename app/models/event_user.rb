class EventUser < ApplicationRecord
    belongs_to :event
    belongs_to :user
    enum :status, [:created, :enrolled]

    def user
        User.unscoped { super }
    end
end
