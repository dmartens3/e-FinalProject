class Province < ApplicationRecord
  has_many :users

  validates :name, presence: true
  validates :code, presence: true, format: { with:    /\A(?:AB|BC|MB|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)\z/,
                                             message: "Must be an uppercase two-character representation of a Canadian province" }
  validates :gst, presence: true
  validates :pst, presence: true
  validates :hst, presence: true
end
