class CreateDestinations < ActiveRecord::Migration[6.1]
  def change
    create_table :destinations do |t|
      t.string :name
      t.string :region
      t.string :banner
      t.string :photo

      t.timestamps
    end
  end
end
