class Customer < ApplicationRecord
    has_many :orders, dependent: :destroy
    validates :fname, :lname, :email, :phoneno, presence: true
    validates :fname, :lname, format: {with: /\A[a-zA-Z]+\Z/, message: "only letters are allowed"}
    validates :phoneno, numericality: {only_integer: true, message: "must be number"},
        length: {is: 10, message: "must be of ten digits"}, uniqueness: true
    validates :email, format: {with: /\A(\S+)@(.+)\.(\S+)\z/, message: "enter valid email"}, uniqueness: true
end
