class Order < ApplicationRecord
  belongs_to :status
  belongs_to :user
  has_many :sales, dependent: :destroy
  
  validates :status_id, :user_id, presence: true
  validates :total, numericality: { greater_than_or_equal_to: 0 }
  validates :stripe_payment_id, uniqueness: true
end
