class Discount < ApplicationRecord
  validates :order, presence: true
  validates :amount, presence: true

  belongs_to :order
end
