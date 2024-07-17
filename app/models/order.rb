# frozen_string_literal: true

#
# Represents a single order
#
class Order < ApplicationRecord
  # has many
  has_many :order_products, dependent: :destroy
  has_many :discounts

  # accepts nested attributes
  accepts_nested_attributes_for :order_products, allow_destroy: true

  # validations
  validates :shipping_date, presence: true

  # methods
  def total
    (order_products.sum(&:subtotal) / total_discounts) * 100
  end

  def total_discounts
    total_discount = discounts.sum(:amount)
    return 100 if total_discount > 100

    total_discount
  end

  # class methods
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value shipping_date updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['order_products']
  end
end
