# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_03_086437) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.binary "album_id"
    t.string "name"
    t.string "genre"
    t.binary "artist_id"
  end

  create_table "artists", force: :cascade do |t|
    t.binary "artist_id"
    t.string "name"
    t.integer "age"
  end

  create_table "tracks", force: :cascade do |t|
    t.binary "track_id"
    t.string "name"
    t.float "duration"
    t.integer "times_played"
    t.binary "artist_id"
    t.binary "album_id"
  end

end
