class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :product, null: false, foreign_key: true
      t.decimal :order_price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
