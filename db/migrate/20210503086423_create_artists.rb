class CreateArtists < ActiveRecord::Migration[6.1]
  def change
    create_table :artists do |t|
      t.binary :artist_id
      t.string :name
      t.integer :age
    end
  end
end
