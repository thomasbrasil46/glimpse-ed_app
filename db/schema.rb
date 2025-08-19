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

ActiveRecord::Schema[8.0].define(version: 2025_08_19_215319) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "access_tokens", force: :cascade do |t|
    t.string "token"
    t.datetime "expires_at"
    t.bigint "media_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_group_id"], name: "index_access_tokens_on_media_group_id"
    t.index ["token"], name: "index_access_tokens_on_token"
  end

  create_table "media_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "media_items", force: :cascade do |t|
    t.bigint "media_group_id", null: false
    t.string "file_path"
    t.string "mime_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_group_id"], name: "index_media_items_on_media_group_id"
  end

  add_foreign_key "access_tokens", "media_groups"
  add_foreign_key "media_items", "media_groups"
end
