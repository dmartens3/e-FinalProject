class Sale < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, :cost, :tax, :product_id, :order_id, presence: true
  
  validates :quantity, :cost, :tax, numericality: { greater_than_or_equal_to: 0 }
end
