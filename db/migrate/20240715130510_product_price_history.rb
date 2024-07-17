class ProductPriceHistory < ActiveRecord::Migration[7.1]
  def change
    create_table :product_price_histories do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :previous_price, null: false
      t.integer :current_price, null: false

      t.timestamps
    end
  end

  def down
    drop_table :product_price_histories
  end
end
