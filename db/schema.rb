# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 8) do

  create_table "authors", :force => true do |t|
    t.string "first_name"
    t.string "last_name"
  end

  create_table "authors_books", :id => false, :force => true do |t|
    t.integer "author_id", :null => false
    t.integer "book_id",   :null => false
  end

  add_index "authors_books", ["author_id"], :name => "fk_bk_authors"
  add_index "authors_books", ["book_id"], :name => "fk_bk_books"

  create_table "books", :force => true do |t|
    t.string   "title",                                                     :default => "", :null => false
    t.integer  "publisher_id",                                                              :null => false
    t.datetime "published_at"
    t.string   "isbn",         :limit => 13
    t.text     "blurb"
    t.integer  "page_count"
    t.decimal  "price",                      :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover_image"
  end

  add_index "books", ["publisher_id"], :name => "fk_books_publishers"

  create_table "books_tags", :id => false, :force => true do |t|
    t.integer "tag_id",  :null => false
    t.integer "book_id", :null => false
  end

  add_index "books_tags", ["tag_id"], :name => "fk_tb_tags"
  add_index "books_tags", ["book_id"], :name => "fk_tb_books"

  create_table "cart_items", :force => true do |t|
    t.integer  "book_id"
    t.integer  "cart_id"
    t.float    "price"
    t.integer  "amount"
    t.datetime "created_at"
  end

  create_table "carts", :force => true do |t|
  end

  create_table "forum_posts", :force => true do |t|
    t.string   "name",       :limit => 50, :default => "", :null => false
    t.string   "subject",                  :default => "", :null => false
    t.text     "body"
    t.integer  "root_id",                  :default => 0,  :null => false
    t.integer  "parent_id",                :default => 0,  :null => false
    t.integer  "lft",                      :default => 0,  :null => false
    t.integer  "rgt",                      :default => 0,  :null => false
    t.integer  "depth",                    :default => 0,  :null => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "order_items", :force => true do |t|
    t.integer  "book_id"
    t.integer  "order_id"
    t.float    "price"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "email"
    t.string   "phone_number"
    t.string   "ship_to_first_name"
    t.string   "ship_to_last_name"
    t.string   "ship_to_address"
    t.string   "ship_to_city"
    t.string   "ship_to_postal_code"
    t.string   "ship_to_country"
    t.string   "customer_ip"
    t.string   "status"
    t.string   "error_message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publishers", :force => true do |t|
    t.string "name", :default => "", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string "name", :default => "", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "pw_reset_code",             :limit => 40
  end

end
