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

ActiveRecord::Schema[7.0].define(version: 2022_11_14_152427) do
  create_table "categories", id: false, force: :cascade do |t|
    t.string "category", null: false
    t.integer "message_count", null: false
    t.string "last_message_id", null: false
    t.integer "last_message_global_position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_categories_on_category", unique: true
  end

  create_table "messages", id: false, force: :cascade do |t|
    t.string "event_id", null: false
    t.string "trace_id", null: false
    t.string "actor_id", null: false
    t.string "stream", null: false
    t.string "event_type", null: false
    t.datetime "timestamp", precision: nil, null: false
    t.json "data", null: false
    t.index ["event_id"], name: "index_messages_on_event_id", unique: true
    t.index ["stream"], name: "index_messages_on_stream"
    t.index ["trace_id"], name: "index_messages_on_trace_id"
  end

  create_table "streams", id: false, force: :cascade do |t|
    t.string "stream", null: false
    t.integer "message_count", null: false
    t.string "last_message_id", null: false
    t.integer "last_message_global_position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stream"], name: "index_streams_on_stream", unique: true
  end

end
