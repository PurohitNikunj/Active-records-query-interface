class User < ApplicationRecord
    attr_accessor :checked
    validates_presence_of :first_name, :last_name, :email, :password
    validates_presence_of :subscription_email, if: :checked
end
