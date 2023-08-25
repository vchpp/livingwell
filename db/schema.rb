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

ActiveRecord::Schema.define(version: 2022_07_19_055713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "additionals", force: :cascade do |t|
    t.string "en_title"
    t.string "en_source"
    t.string "en_content"
    t.string "en_external_link"
    t.string "en_notes"
    t.string "zh_tw_title"
    t.string "zh_tw_source"
    t.string "zh_tw_content"
    t.string "zh_tw_external_link"
    t.string "zh_tw_notes"
    t.string "zh_cn_title"
    t.string "zh_cn_source"
    t.string "zh_cn_content"
    t.string "zh_cn_external_link"
    t.string "zh_cn_notes"
    t.string "vi_title"
    t.string "vi_source"
    t.string "vi_content"
    t.string "vi_external_link"
    t.string "vi_notes"
    t.string "hm_title"
    t.string "hm_source"
    t.string "hm_content"
    t.string "hm_external_link"
    t.string "hm_notes"
    t.string "kr_title"
    t.string "kr_source"
    t.string "kr_content"
    t.string "kr_external_link"
    t.string "kr_notes"
    t.string "languages", default: [], array: true
    t.string "tags", default: [], array: true
    t.date "last_version_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.string "category", default: "general"
    t.boolean "featured", default: false
    t.boolean "archive", default: false
    t.index ["slug"], name: "index_additionals_on_slug", unique: true
  end

  create_table "audit_logs", force: :cascade do |t|
    t.string "action", null: false
    t.bigint "user_id"
    t.bigint "record_id"
    t.string "record_type"
    t.text "payload"
    t.text "request"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["action"], name: "index_audit_logs_on_action"
    t.index ["record_type", "record_id"], name: "index_audit_logs_on_record_type_and_record_id"
    t.index ["user_id", "action"], name: "index_audit_logs_on_user_id_and_action"
  end

  create_table "callouts", force: :cascade do |t|
    t.string "en_title"
    t.string "en_body"
    t.string "en_link_name"
    t.string "zh_tw_title"
    t.string "zh_tw_body"
    t.string "zh_tw_link_name"
    t.string "zh_cn_title"
    t.string "zh_cn_body"
    t.string "zh_cn_link_name"
    t.string "vi_title"
    t.string "vi_body"
    t.string "vi_link_name"
    t.string "hm_title"
    t.string "hm_body"
    t.string "hm_link_name"
    t.string "kr_title"
    t.string "kr_body"
    t.string "kr_link_name"
    t.string "link"
    t.boolean "external_link"
    t.boolean "archive"
    t.string "tags", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "en_link_url"
    t.string "zh_tw_link_url"
    t.string "zh_cn_link_url"
    t.string "vi_link_url"
    t.string "hm_link_url"
    t.string "kr_link_url"
    t.integer "priority"
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.string "dt"
    t.bigint "message_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["message_id"], name: "index_comments_on_message_id"
  end

  create_table "downloads", force: :cascade do |t|
    t.string "en_title"
    t.string "zh_tw_title"
    t.string "zh_cn_title"
    t.string "vi_title"
    t.string "hm_title"
    t.string "kr_title"
    t.string "en_file"
    t.string "zh_tw_file"
    t.string "zh_cn_file"
    t.string "vi_file"
    t.string "hm_file"
    t.string "kr_file"
    t.string "category"
    t.boolean "archive"
    t.string "tags", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "languages", default: [], array: true
  end

  create_table "faqs", force: :cascade do |t|
    t.string "en_question"
    t.string "zh_tw_question"
    t.string "zh_cn_question"
    t.string "hm_question"
    t.string "vi_question"
    t.string "kr_question"
    t.string "category"
    t.string "tags", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.boolean "archive", default: false
    t.index ["slug"], name: "index_faqs_on_slug", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "healthwise_articles", force: :cascade do |t|
    t.string "hwid"
    t.string "article_or_topic"
    t.string "en_title"
    t.jsonb "en_json", default: {}
    t.boolean "en_translated", default: false
    t.string "zh_tw_title"
    t.jsonb "zh_tw_json", default: {}
    t.boolean "zh_tw_translated", default: false
    t.string "zh_cn_title"
    t.jsonb "zh_cn_json", default: {}
    t.boolean "zh_cn_translated", default: false
    t.string "vi_title"
    t.jsonb "vi_json", default: {}
    t.boolean "vi_translated", default: false
    t.string "hm_title"
    t.jsonb "hm_json", default: {}
    t.boolean "hm_translated", default: false
    t.string "kr_title"
    t.jsonb "kr_json", default: {}
    t.boolean "kr_translated", default: false
    t.string "languages", default: [], array: true
    t.string "tags", default: [], array: true
    t.string "category"
    t.boolean "featured", default: false
    t.boolean "archive", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.string "en_rich_text"
    t.string "zh_tw_rich_text"
    t.string "zh_cn_rich_text"
    t.string "vi_rich_text"
    t.string "hm_rich_text"
    t.string "kr_rich_text"
    t.index ["slug"], name: "index_healthwise_articles_on_slug", unique: true
  end

  create_table "likes", force: :cascade do |t|
    t.string "up", default: "0"
    t.string "down", default: "0"
    t.string "dt"
    t.bigint "message_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "likeable_type"
    t.bigint "likeable_id"
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable"
    t.index ["message_id"], name: "index_likes_on_message_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "en_name"
    t.string "en_content"
    t.string "zh_cn_name"
    t.string "zh_cn_content"
    t.string "zh_tw_name"
    t.string "zh_tw_content"
    t.string "vi_name"
    t.string "vi_content"
    t.string "hm_name"
    t.string "hm_content"
    t.string "kr_name"
    t.string "kr_content"
    t.string "tags", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "en_action_item"
    t.string "zh_tw_action_item"
    t.string "zh_cn_action_item"
    t.string "vi_action_item"
    t.string "hm_action_item"
    t.string "kr_action_item"
    t.string "external_links", default: [], array: true
    t.string "slug"
    t.string "survey_link"
    t.string "en_external_rich_links"
    t.string "zh_tw_external_rich_links"
    t.string "zh_cn_external_rich_links"
    t.string "vi_external_rich_links"
    t.string "hm_external_rich_links"
    t.string "kr_external_rich_links"
    t.string "category", default: "general"
    t.boolean "archive", default: false
    t.index ["slug"], name: "index_messages_on_slug", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.string "firstname"
    t.string "middlename"
    t.string "middlename2"
    t.string "lastname"
    t.string "profile_type"
    t.string "external_link"
    t.string "en_project_title"
    t.string "zh_tw_project_title"
    t.string "zh_cn_project_title"
    t.string "vi_project_title"
    t.string "hm_project_title"
    t.string "kr_project_title"
    t.string "en_affiliation"
    t.string "zh_tw_affiliation"
    t.string "zh_cn_affiliation"
    t.string "vi_affiliation"
    t.string "hm_affiliation"
    t.string "kr_affiliation"
    t.string "en_bio"
    t.string "zh_tw_bio"
    t.string "zh_cn_bio"
    t.string "vi_bio"
    t.string "hm_bio"
    t.string "kr_bio"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.string "fullname"
    t.string "external_links", default: [], array: true
    t.boolean "archive", default: false
    t.index ["slug"], name: "index_profiles_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.boolean "healthwise", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "messages"
  add_foreign_key "likes", "messages"
end
