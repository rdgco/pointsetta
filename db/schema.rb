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

ActiveRecord::Schema[8.0].define(version: 2025_02_25_005944) do
  create_table "participants", force: :cascade do |t|
    t.string "name", null: false
    t.integer "pointing_session_id", null: false
    t.boolean "administrator", default: false
    t.integer "vote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pointing_session_id"], name: "index_participants_on_pointing_session_id"
  end

  create_table "pointing_sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "topic"
    t.string "string"
    t.index ["name"], name: "index_pointing_sessions_on_name", unique: true
  end
end
