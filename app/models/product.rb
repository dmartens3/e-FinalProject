class Product < ApplicationRecord
  # allow an image to be attached and returns a thumbnail when you ask for the thumb variant.
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
    attachable.variant :small, resize_to_limit: [200, 200]
  end

  belongs_to :category
  has_many :sales, dependent: :destroy

  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
