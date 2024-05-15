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

ActiveRecord::Schema[7.1].define(version: 2022_05_23_231634) do
  create_table "abuseusers", force: :cascade do |t|
    t.integer "abuse_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chinese_horoscope_dates", force: :cascade do |t|
    t.integer "chinese_horoscope_id"
    t.date "begin"
    t.date "end"
  end

  create_table "chinese_horoscopes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "pro"
    t.text "con"
    t.string "lucky_numbers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emojis", force: :cascade do |t|
    t.string "code"
  end

  create_table "interests", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messagehaveprivatephotos", force: :cascade do |t|
    t.integer "photo_id"
    t.integer "message_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.integer "sender_id"
    t.integer "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read"
  end

  create_table "myblacklistedusers", force: :cascade do |t|
    t.integer "blacklisted_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myfavoriteusers", force: :cascade do |t|
    t.integer "favorite_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myprivatephotos", force: :cascade do |t|
    t.integer "user_id"
    t.integer "photo_id"
  end

  create_table "mypublicphotos", force: :cascade do |t|
    t.integer "user_id"
    t.integer "photo_id"
  end

  create_table "orthodox_horoscopes", force: :cascade do |t|
    t.date "begin"
    t.date "end"
    t.string "name"
    t.text "description"
    t.text "celebrities"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "notinguser_id"
    t.integer "rating"
  end

  create_table "relationships", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "userinterests", force: :cascade do |t|
    t.integer "interest_id"
    t.integer "user_id"
  end

  create_table "userrelationships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "relationship_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender"
    t.boolean "femalesearched"
    t.boolean "malesearched"
    t.date "dateofbirth"
    t.string "phonenumber"
    t.string "latitude"
    t.string "longitude"
    t.string "name"
    t.string "fake_country"
    t.string "country"
    t.boolean "opt_in"
    t.boolean "online"
    t.string "image"
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "weight"
    t.string "height"
    t.string "subdivision"
    t.text "description"
    t.boolean "showinfo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
