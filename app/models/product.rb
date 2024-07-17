# frozen_string_literal: true

#
# Represents a single product
#
class Product < ApplicationRecord
  # belongs to
  belongs_to :sku

  # validations
  validates :name, presence: true
  validates :price_in_cents, presence: true

  has_many :product_price_histories

  before_update :check_if_price_changed
  # class methods
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value name price_in_cents sku_id updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['sku']
  end

  def check_if_price_changed
    return unless price_in_cents_changed?

    ProductPriceHistory.create!(product: self, previous_price: price_in_cents_was, current_price: price_in_cents)
  end
end
