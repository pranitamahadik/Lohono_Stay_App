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

ActiveRecord::Schema[7.0].define(version: 2023_10_24_100704) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calenders", force: :cascade do |t|
    t.bigint "villa_id", null: false
    t.integer "rate_per_night"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_date"], name: "index_calenders_on_end_date"
    t.index ["start_date"], name: "index_calenders_on_start_date"
    t.index ["villa_id"], name: "index_calenders_on_villa_id"
  end

  create_table "villas", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "calenders", "villas"
end
