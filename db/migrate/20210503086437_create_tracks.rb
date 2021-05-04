class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks do |t|
      t.binary :track_id
      t.string :name
      t.float :duration
      t.integer :times_played
      t.binary :artist_id 
      t.binary :album_id
    end
  end
end

