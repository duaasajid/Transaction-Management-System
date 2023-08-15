class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_one :account

  validates :email, :password, presence: true
  #validates :username, uniqueness: true
  validates :password, length: {minimum: 8}
end
