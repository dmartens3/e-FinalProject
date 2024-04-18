class Order < ApplicationRecord
  belongs_to :status
  belongs_to :user
  has_many :sales
end
