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

ActiveRecord::Schema.define(version: 20130310031141) do

  create_table "docs", force: true do |t|
    t.string   "text1"
    t.string   "text2"
    t.string   "text3"
    t.string   "text4"
    t.string   "text5"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "samplegames", force: true do |t|
    t.string   "start"
    t.string   "target"
    t.string   "estimated_difficulty"
    t.string   "author"
    t.integer  "shortest_path"
    t.integer  "radius"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_type"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.string   "email"
    t.string   "name"
    t.string   "location"
    t.string   "school"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
    t.integer  "total_score"
  end

  create_table "warps", force: true do |t|
    t.integer  "user_id"
    t.integer  "samplegame_id"
    t.integer  "difficulty"
    t.integer  "score"
    t.integer  "links"
    t.integer  "time"
    t.string   "start"
    t.string   "target"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
