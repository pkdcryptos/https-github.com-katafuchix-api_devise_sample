class InitScheme < ActiveRecord::Migration[6.0]
  def change

    create_table "taggings" do |t|
      t.integer  "tag_id"
      t.string   "taggable_type"
      t.integer  "taggable_id"
      t.string   "tagger_type"
      t.integer  "tagger_id"
      t.string   "context",       limit: 128
      t.datetime "created_at"
      t.index ["context"], name: "index_taggings_on_context", using: :btree
      t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
      t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
      t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
      t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
      t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
      t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
      t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
      t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
    end

    create_table "tags" do |t|
      t.string  "name"
      t.integer "taggings_count", default: 0
      t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
    end

  end
end