class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.references :author, null: false, foreign_key: {to_table: :users}
      t.string :stripe_account_id, null: false
      t.boolean :charges_enabled, default: false
      t.boolean :transfers_enabled, default: false
      t.boolean :details_submitted, default: false

      t.timestamps
    end
    add_index :accounts, :stripe_account_id, unique: true
  end
end
