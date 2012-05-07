class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer  :tag_id, null: false
      t.integer  :transaction_id, null: false
      t.timestamps
    end
  end
end
