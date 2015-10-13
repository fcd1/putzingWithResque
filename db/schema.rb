# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151013152356) do

  create_table "digital_object_imports", force: :cascade do |t|
    t.text     "digital_object_data", limit: 65535
    t.integer  "status",              limit: 4,     null: false
    t.integer  "import_job_id",       limit: 4,     null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "digital_object_imports", ["import_job_id"], name: "index_digital_object_imports_on_import_job_id", using: :btree

  create_table "import_jobs", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.integer  "user_id",    limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "import_jobs", ["user_id"], name: "index_import_jobs_on_user_id", using: :btree

  create_table "records", force: :cascade do |t|
    t.string   "test_string", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_foreign_key "digital_object_imports", "import_jobs"
  add_foreign_key "import_jobs", "users"
end
