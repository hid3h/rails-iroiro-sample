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

ActiveRecord::Schema.define(version: 2021_09_04_015522) do

  create_table "delete_all_children", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "delete_all_parent_id", null: false
    t.index ["delete_all_parent_id"], name: "index_delete_all_children_on_delete_all_parent_id"
  end

  create_table "delete_all_parents", charset: "utf8mb4", force: :cascade do |t|
  end

  add_foreign_key "delete_all_children", "delete_all_parents"
end
