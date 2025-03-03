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

ActiveRecord::Schema[7.1].define(version: 2025_03_03_181815) do
  create_table "bids", force: :cascade do |t|
    t.decimal "amount"
    t.integer "carrier_id", null: false
    t.integer "load_id", null: false
    t.integer "route_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_bids_on_carrier_id"
    t.index ["load_id"], name: "index_bids_on_load_id"
    t.index ["route_id"], name: "index_bids_on_route_id"
  end

  create_table "carriers", force: :cascade do |t|
    t.string "carrier_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loads", force: :cascade do |t|
    t.integer "load_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.string "from"
    t.string "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bids", "carriers"
  add_foreign_key "bids", "loads"
  add_foreign_key "bids", "routes"
end
