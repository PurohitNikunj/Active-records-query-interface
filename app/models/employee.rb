class Employee < ApplicationRecord
    attr_accessor :skip
    has_secure_password
    has_many :employee_addresses, dependent: :destroy
    validates :employee_name, :email, :gender, :mobile_number, :birth_date, :document, presence: true
    validates :password, presence: true, if: :skip
    validates_confirmation_of :password, if: :skip
    validates_presence_of :password_confirmation, if: :skip
    serialize :hobbies, Array
    accepts_nested_attributes_for :employee_addresses
    # validates :mobile_number, numericality: {only_integer: true, message: "must be number"},
    # length: {is: 10, message: "must be of ten digits"}, uniqueness: true

end
