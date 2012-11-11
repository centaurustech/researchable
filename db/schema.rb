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

ActiveRecord::Schema.define(:version => 20121030141648) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"

  create_table "backers", :force => true do |t|
    t.integer  "project_id",                               :null => false
    t.integer  "user_id",                                  :null => false
    t.integer  "reward_id"
    t.decimal  "value",                                    :null => false
    t.boolean  "confirmed",             :default => false, :null => false
    t.datetime "confirmed_at"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.boolean  "anonymous",             :default => false
    t.text     "key"
    t.boolean  "requested_refund",      :default => false
    t.boolean  "refunded",              :default => false
    t.boolean  "credits",               :default => false
    t.boolean  "notified_finish",       :default => false
    t.text     "payment_method"
    t.text     "payment_token"
    t.string   "payment_id"
    t.text     "payer_name"
    t.text     "payer_email"
    t.text     "payer_document"
    t.text     "address_street"
    t.text     "address_number"
    t.text     "address_complement"
    t.text     "address_neighbourhood"
    t.text     "address_zip_code"
    t.text     "address_city"
    t.text     "address_state"
    t.text     "address_phone_number"
    t.text     "payment_choice"
    t.decimal  "payment_service_fee"
  end

  add_index "backers", ["confirmed"], :name => "index_backers_on_confirmed"
  add_index "backers", ["key"], :name => "index_backers_on_key"
  add_index "backers", ["project_id"], :name => "index_backers_on_project_id"
  add_index "backers", ["project_id"], :name => "index_confirmed_backers_on_project_id"
  add_index "backers", ["reward_id"], :name => "index_backers_on_reward_id"
  add_index "backers", ["user_id"], :name => "index_backers_on_user_id"

  create_table "categories", :force => true do |t|
    t.text     "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["name"], :name => "categories_name_unique", :unique => true
  add_index "categories", ["name"], :name => "index_categories_on_name"

  create_table "comments", :force => true do |t|
    t.text     "title"
    t.text     "comment",                             :null => false
    t.text     "comment_html"
    t.integer  "commentable_id",                      :null => false
    t.string   "commentable_type",                    :null => false
    t.integer  "user_id",                             :null => false
    t.boolean  "project_update",   :default => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "configurations", :force => true do |t|
    t.text     "name",       :null => false
    t.text     "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "curated_pages", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "analytics_id"
    t.string   "logo"
    t.string   "video_url"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "permalink"
    t.boolean  "visible",      :default => false
    t.string   "site_url"
  end

  add_index "curated_pages", ["permalink"], :name => "index_curated_pages_on_permalink"

  create_table "institutional_videos", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "video_url"
    t.boolean  "visible"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "notification_types", :force => true do |t|
    t.text     "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "notification_types", ["name"], :name => "index_notification_types_on_name", :unique => true

  create_table "notifications", :force => true do |t|
    t.integer  "user_id",                                 :null => false
    t.integer  "project_id"
    t.text     "text",                                    :null => false
    t.text     "twitter_text"
    t.text     "facebook_text"
    t.text     "email_subject"
    t.text     "email_text"
    t.boolean  "dismissed",            :default => false, :null => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "notification_type_id"
    t.integer  "backer_id"
  end

  create_table "oauth_providers", :force => true do |t|
    t.text     "name",       :null => false
    t.text     "key",        :null => false
    t.text     "secret",     :null => false
    t.text     "scope"
    t.integer  "order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "strategy"
    t.text     "path"
  end

  add_index "oauth_providers", ["name"], :name => "oauth_providers_name_unique", :unique => true

  create_table "payment_logs", :force => true do |t|
    t.integer  "backer_id"
    t.integer  "status"
    t.float    "amount"
    t.integer  "payment_status"
    t.integer  "moip_id"
    t.integer  "payment_method"
    t.string   "payment_type"
    t.string   "consumer_email"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "payment_notifications", :force => true do |t|
    t.integer  "backer_id",  :null => false
    t.text     "extra_data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.text     "name",                                 :null => false
    t.integer  "user_id",                              :null => false
    t.integer  "category_id",                          :null => false
    t.decimal  "goal",                                 :null => false
    t.datetime "expires_at",                           :null => false
    t.text     "about",                                :null => false
    t.text     "headline",                             :null => false
    t.text     "video_url"
    t.text     "image_url"
    t.text     "short_url"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "can_finish",        :default => false
    t.boolean  "finished",          :default => false
    t.text     "about_html"
    t.boolean  "visible",           :default => true
    t.boolean  "rejected",          :default => false
    t.boolean  "recommended",       :default => false
    t.text     "home_page_comment"
    t.boolean  "successful",        :default => false
    t.string   "permalink"
    t.text     "flickr_url"
    t.text     "flickr_image"
    t.text     "flickr_thumb"
    t.text     "flickr_square"
    t.string   "academic_email"
    t.text     "video_thumbnail"
  end

  add_index "projects", ["category_id"], :name => "index_projects_on_category_id"
  add_index "projects", ["name"], :name => "index_projects_on_name"
  add_index "projects", ["permalink"], :name => "index_projects_on_permalink", :unique => true
  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "projects_curated_pages", :force => true do |t|
    t.integer  "project_id"
    t.integer  "curated_page_id"
    t.text     "description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.text     "description_html"
  end

  create_table "projects_managers", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "project_id"
  end

  create_table "rewards", :force => true do |t|
    t.integer  "project_id",      :null => false
    t.decimal  "minimum_value",   :null => false
    t.integer  "maximum_backers"
    t.text     "description",     :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "rewards", ["project_id"], :name => "index_rewards_on_project_id"

  create_table "states", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "acronym",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "states", ["acronym"], :name => "states_acronym_unique", :unique => true
  add_index "states", ["name"], :name => "states_name_unique", :unique => true

  create_table "static_contents", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.text     "body_html"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "updates", :force => true do |t|
    t.integer  "user_id",      :null => false
    t.integer  "project_id",   :null => false
    t.text     "title"
    t.text     "comment",      :null => false
    t.text     "comment_html", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "primary_user_id"
    t.text     "provider",                                                 :null => false
    t.text     "uid",                                                      :null => false
    t.text     "email"
    t.text     "name"
    t.text     "nickname"
    t.text     "bio"
    t.text     "image_url"
    t.boolean  "newsletter",                            :default => false
    t.boolean  "project_updates",                       :default => false
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.boolean  "admin",                                 :default => false
    t.text     "full_name"
    t.text     "address_street"
    t.text     "address_number"
    t.text     "address_complement"
    t.text     "address_neighbourhood"
    t.text     "address_city"
    t.text     "address_state"
    t.text     "address_zip_code"
    t.text     "phone_number"
    t.decimal  "credits",                               :default => 0.0
    t.text     "locale",                                :default => "pt",  :null => false
    t.text     "cpf"
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "twitter"
    t.string   "facebook_link"
    t.string   "other_link"
    t.text     "uploaded_image"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["email"], :name => "users_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["provider", "uid"], :name => "users_provider_uid_unique", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["uid"], :name => "index_users_on_uid"

  add_foreign_key "backers", "projects", :name => "backers_project_id_reference"
  add_foreign_key "backers", "rewards", :name => "backers_reward_id_reference"
  add_foreign_key "backers", "users", :name => "backers_user_id_reference"

  add_foreign_key "comments", "users", :name => "comments_user_id_reference"

  add_foreign_key "notifications", "backers", :name => "notifications_backer_id_fk"
  add_foreign_key "notifications", "notification_types", :name => "notifications_notification_type_id_fk"
  add_foreign_key "notifications", "projects", :name => "notifications_project_id_reference"
  add_foreign_key "notifications", "users", :name => "notifications_user_id_reference"

  add_foreign_key "payment_notifications", "backers", :name => "payment_notifications_backer_id_fk"

  add_foreign_key "projects", "categories", :name => "projects_category_id_reference"
  add_foreign_key "projects", "users", :name => "projects_user_id_reference"

  add_foreign_key "rewards", "projects", :name => "rewards_project_id_reference"

  add_foreign_key "updates", "projects", :name => "updates_project_id_fk"
  add_foreign_key "updates", "users", :name => "updates_user_id_fk"

  add_foreign_key "users", "users", :name => "users_primary_user_id_reference", :column => "primary_user_id"

end
