class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.references :destination, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.decimal :price
      t.decimal :rating

      t.timestamps
    end
  end
end
