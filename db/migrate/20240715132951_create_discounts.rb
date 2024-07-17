class CreateDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :discounts do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
