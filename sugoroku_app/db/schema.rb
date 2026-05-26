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

ActiveRecord::Schema[8.1].define(version: 2026_05_25_095402) do
  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "current_player_order", default: 0
    t.text "description"
    t.integer "max_players"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "game_id", null: false
    t.boolean "is_goal"
    t.string "name"
    t.integer "position"
    t.integer "rank"
    t.integer "skip_turns"
    t.integer "turn_order"
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_players_on_game_id"
  end

  create_table "squares", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "effect"
    t.integer "game_id", null: false
    t.integer "position"
    t.string "square_type"
    t.string "text"
    t.datetime "updated_at", null: false
    t.integer "value"
    t.index ["game_id"], name: "index_squares_on_game_id"
  end

  add_foreign_key "players", "games"
  add_foreign_key "squares", "games"
end
