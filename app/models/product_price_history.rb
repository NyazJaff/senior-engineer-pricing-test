# frozen_string_literal: true

#
# Represents a single product
#
class ProductPriceHistory < ApplicationRecord
  belongs_to :product

  # validations
  validates :product, presence: true
  validates :previous_price, presence: true
  validates :current_price, presence: true
end
