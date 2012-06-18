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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120618063411) do

  create_table "accounts", :force => true do |t|
    t.string   "user_id",                                                            :null => false
    t.boolean  "public",                                          :default => true
    t.string   "currency",                                        :default => "PLN"
    t.decimal  "balance_in_cents", :precision => 16, :scale => 0, :default => 0
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
  end

  create_table "invitations", :force => true do |t|
    t.integer  "user_id",         :null => false
    t.integer  "recipient_id"
    t.integer  "account_id"
    t.string   "recipient_email"
    t.string   "recipient_phone"
    t.integer  "state"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.string   "name"
    t.string   "surname"
    t.integer  "age"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "sessions", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id",         :null => false
    t.integer  "transaction_id", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "tags", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "transactions", :force => true do |t|
    t.integer  "user_id",                                                               :null => false
    t.integer  "account_id",                                                            :null => false
    t.decimal  "value_in_cents",          :precision => 16, :scale => 0, :default => 0
    t.date     "date"
    t.text     "description"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "phone"
    t.string   "password_digest", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
