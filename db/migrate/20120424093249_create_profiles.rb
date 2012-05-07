class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer  :user_id, null: false
      t.string   :name
      t.string   :surname
      t.integer  :age
      t.text     :description
      t.timestamps
    end
  end
end
