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

ActiveRecord::Schema.define(version: 20161220164735) do

  create_table "oauth_access_grants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "resource_owner_id",               null: false
    t.integer  "application_id",                  null: false
    t.string   "token",                           null: false
    t.integer  "expires_in",                      null: false
    t.text     "redirect_uri",      limit: 65535, null: false
    t.datetime "created_at",                      null: false
    t.datetime "revoked_at"
    t.string   "scopes"
    t.index ["application_id"], name: "fk_rails_b4b53e07b8", using: :btree
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree
  end

  create_table "oauth_access_tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",                               null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",                          null: false
    t.string   "scopes"
    t.string   "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "fk_rails_732cb83ab7", using: :btree
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree
  end

  create_table "oauth_applications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name",                                    null: false
    t.string   "uid",                                     null: false
    t.string   "secret",                                  null: false
    t.text     "redirect_uri", limit: 65535,              null: false
    t.string   "scopes",                     default: "", null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree
  end

  create_table "user_keywords", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.string   "keyword",                            default: "", null: false
    t.integer  "top_adwords_count",                  default: 0,  null: false
    t.integer  "bottom_adwords_count",               default: 0,  null: false
    t.integer  "total_adwords_count",                default: 0,  null: false
    t.integer  "non_adwords_count",                  default: 0,  null: false
    t.integer  "total_link_count",                   default: 0,  null: false
    t.text     "top_adword_urls",      limit: 65535,              null: false
    t.text     "bottom_adword_urls",   limit: 65535,              null: false
    t.text     "non_adword_urls",      limit: 65535,              null: false
    t.text     "total_search_result",  limit: 65535,              null: false
    t.text     "raw_html",             limit: 65535,              null: false
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.index ["user_id"], name: "index_user_keywords_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
end
