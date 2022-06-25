class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.references :destination, null: false, foreign_key: true
      t.string :name
      t.decimal :stars

      t.timestamps
    end
  end
end
