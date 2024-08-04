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

ActiveRecord::Schema[7.0].define(version: 2024_08_04_102532) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "markets", force: :cascade do |t|
    t.date "current_date"
    t.decimal "price", precision: 10, scale: 2
    t.bigint "user_id"
    t.json "price_history", default: []
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_markets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.bigint "telegram_id"
    t.decimal "capital", precision: 10, scale: 2, default: "10000.0"
    t.integer "amount_of_tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "markets", "users"
end
