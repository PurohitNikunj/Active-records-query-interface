class Employee < ApplicationRecord
    validates :first_name, :last_name, :email, :age, :no_of_orders, :salary, presence: true
    validates :first_name, :last_name, format: {with: /\A[a-zA-Z]+\Z/, message: "only letters are allowed"}
    validates :email, format: {with: /\A(\S+)@(.+)\.(\S+)\z/, message: "enter valid email"}, uniqueness: true
    validates :age, :no_of_orders, :salary, numericality: {only_integer: true, message: "must be number"}

end
