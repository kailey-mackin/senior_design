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

ActiveRecord::Schema.define(version: 20231121052252) do

  create_table "quiz_sounds", force: :cascade do |t|
    t.integer "quiz_id"
    t.integer "sound_id"
  end

  add_index "quiz_sounds", ["quiz_id", "sound_id"], name: "index_quiz_sounds_on_quiz_id_and_sound_id", unique: true

  create_table "quizzes", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.integer  "user_id"
    t.string   "which_grbas_letter"
  end

  add_index "quizzes", ["user_id"], name: "index_quizzes_on_user_id"

  create_table "responses", force: :cascade do |t|
    t.integer  "rating"
    t.text     "reasoning"
    t.datetime "created_at"
    t.integer  "quiz_id"
    t.integer  "sound_id"
    t.integer  "user_id"
  end

  add_index "responses", ["quiz_id"], name: "index_responses_on_quiz_id"
  add_index "responses", ["sound_id"], name: "index_responses_on_sound_id"
  add_index "responses", ["user_id"], name: "index_responses_on_user_id"

  create_table "sounds", force: :cascade do |t|
    t.integer "sound_id"
    t.string  "db_file_name"
    t.text    "score_explanation"
    t.text    "hint"
    t.integer "g_rating"
    t.integer "r_rating"
    t.integer "b_rating"
    t.integer "a_rating"
    t.integer "s_rating"
    t.text    "audio_file_path"
  end

end
