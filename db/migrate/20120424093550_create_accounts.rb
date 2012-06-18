class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer  :user_id, null: false
      t.boolean  :public, default: true
      t.string   :currency, default: "PLN"
      t.decimal  :balance_in_cents, scale: 0, precision: 16, default: 0
      t.timestamps
    end
  end
end
