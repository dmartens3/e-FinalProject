class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/,
  message: "Email format is invalid" }
  validates :address, presence: true
  validates :city, presence: true
  # validates :province, presence: true, format: { with: /\A(?:AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)\z/,
  # message: "Must be an uppercase two-character representation of a Canadian province" }
  validates :postal_code, presence: true, format: { with: /\A([ABCEGHJKLMNPRSTVXY]\d[ABCEGHJKLMNPRSTVWXYZ])[\s-]?(\d[ABCEGHJKLMNPRSTVWXYZ]\d)\z/i,
  message: "Must be a valid Canadian postal code" }
end
