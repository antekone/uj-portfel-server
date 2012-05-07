class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer  :user_id, null: false
      t.integer  :account_id, null: false
      t.decimal  :value_in_cents, scale: 0, precision: 16, default: 0
      t.date     :date
      t.text     :description
      t.has_attached_file :attachment
      t.timestamps
    end
  end
end
