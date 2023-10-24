class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.references :reader, null: false, foreign_key: {to_table: :users}
      t.string :stripe_customer_id

      t.timestamps
    end
    add_index :customers, :stripe_customer_id, unique: true
  end
end
