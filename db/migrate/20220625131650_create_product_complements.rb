class CreateProductComplements < ActiveRecord::Migration[6.1]
  def change
    create_table :product_complements do |t|
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end
