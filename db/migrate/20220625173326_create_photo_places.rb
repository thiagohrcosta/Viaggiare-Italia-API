class CreatePhotoPlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :photo_places do |t|
      t.string :photo_url

      t.timestamps
    end
  end
end
