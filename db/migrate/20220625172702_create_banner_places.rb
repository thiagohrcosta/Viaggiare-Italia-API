class CreateBannerPlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :banner_places do |t|
      t.string :photo_url

      t.timestamps
    end
  end
end
