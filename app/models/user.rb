class User < ApplicationRecord
    has_secure_password
    validates :fname, :lname, :email, :password, presence: true
    validates_confirmation_of :password
    validates_presence_of :password_confirmation
    validates :fname, :lname, format: {with: /\A[a-zA-Z]+\Z/, message: "only letters are allowed"}
    validates :email, format: {with: /\A(\S+)@(.+)\.(\S+)\z/, message: "enter valid email"}, uniqueness: true
    has_many :event_users, dependent: :destroy
    has_many :events, through: :event_users
    has_one :address, dependent: :destroy
    has_many :comments, dependent: :destroy
    default_scope { where(is_active: false) }
end
