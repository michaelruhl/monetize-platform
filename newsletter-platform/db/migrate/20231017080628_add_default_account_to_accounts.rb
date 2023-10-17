class AddDefaultAccountToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :default_account, :boolean, default: true
  end
end
