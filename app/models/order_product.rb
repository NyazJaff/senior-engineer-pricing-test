# frozen_string_literal: true

#
# Represents a line item on the order
# Contains the quantity of the given product added to the order
#
class OrderProduct < ApplicationRecord
  # belongs to
  belongs_to :order
  belongs_to :product

  # validations
  validates :quantity, presence: true
  validates :each_item_price_in_cents, presence: true
  # attr_readonly :each_item_price_in_cents TODO to be enabled after the migration has been executed on production
  #
  # Calculates the subtotal for the given order product
  #
  # @return [Integer] the subtotal
  #

  before_create do
    self.each_item_price_in_cents = product.price_in_cents
  end

  def subtotal
    quantity * each_item_price_in_cents
  end

  # class methods
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value order_id product_id quantity each_item_price_in_cents updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[order product]
  end
end
