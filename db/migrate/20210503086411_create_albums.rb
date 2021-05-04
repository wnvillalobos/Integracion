class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :albums do |t|
      t.binary :album_id
      t.string :name
      t.string :genre
      t.binary :artist_id
    end
  end
end
