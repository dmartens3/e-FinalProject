class User < ApplicationRecord
  has_many :orders
  belongs_to :province
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true, format: { with:    /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/,
                                                                message: "Email format is invalid" }
  validates :address, :city, presence: true
  validates :postal_code, presence: true, format: { with:    /\A([ABCEGHJKLMNPRSTVXY]\d[ABCEGHJKLMNPRSTVWXYZ])[\s-]?(\d[ABCEGHJKLMNPRSTVWXYZ]\d)\z/i,
                                                    message: "Must be a valid Canadian postal code" }
end
