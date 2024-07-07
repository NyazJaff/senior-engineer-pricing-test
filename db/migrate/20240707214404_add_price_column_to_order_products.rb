class AddPriceColumnToOrderProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :order_products, :each_item_price_in_cents, :integer , null: false, default: 0

    # Updating historical records.
    # 1. This ensures future price changes to product will not effect existing orders
    # 2. during customer refunds customers will be refunded the correct price
    OrderProduct.in_batches.each_record do |order_product|
      order_product.update_column :each_item_price_in_cents, order_product.product.price_in_cents
    end

    def down
      remove_columns :order_products, :each_item_price_in_cents
    end
  end
end
