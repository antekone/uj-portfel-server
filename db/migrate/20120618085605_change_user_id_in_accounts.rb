class ChangeUserIdInAccounts < ActiveRecord::Migration
  def up
    remove_column :accounts, :user_id
    add_column :accounts, :user_id, :integer
  end

  def down
    remove_column :accounts, :user_id
    add_column :accounts, :user_id, :string
  end
end