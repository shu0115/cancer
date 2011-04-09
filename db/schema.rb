# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110407063323) do

  create_table "entries", :force => true do |t|
    t.string   "name"
    t.date     "schedule_day"
    t.string   "attend"
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.date     "event_day"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "mode"
    t.string   "show_key"
  end

  create_table "schedules", :force => true do |t|
    t.date     "schedule_day"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login_id"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "display_name"
    t.string   "level"
    t.string   "twitter_id"
    t.string   "mail_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
