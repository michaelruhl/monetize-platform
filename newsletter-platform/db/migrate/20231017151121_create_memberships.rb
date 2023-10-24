class CreateMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :memberships do |t|
      t.references :newsletter, null: false, foreign_key: true
      t.references :reader, null: false, foreign_key: { to_table: :users }
      t.string :stripe_subscription_id
      t.string :status, null: false, default: 'pending'
      t.string :stripe_checkout_session_id

      t.timestamps
    end
    add_index :memberships, [:newsletter_id, :reader_id], unique: true
    add_index :memberships, :stripe_subscription_id, unique: true
  end
end
