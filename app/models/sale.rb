class Sale < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, :cost, :tax, presence: true

  validates :quantity, :cost, :tax, numericality: { greater_than_or_equal_to: 0 }
end
