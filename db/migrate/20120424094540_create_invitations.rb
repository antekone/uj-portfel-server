class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer  :user_id, null: false
      t.integer  :recipient_id
      t.integer  :account_id
      t.string   :recipient_email
      t.string   :recipient_phone
      t.integer  :state
      t.timestamps
    end
  end
end
