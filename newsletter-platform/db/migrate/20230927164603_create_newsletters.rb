class CreateNewsletters < ActiveRecord::Migration[7.1]
  def change
    create_table :newsletters do |t|
      t.references :author, null: false, foreign_key: {to_table: :users}
      t.string :title, null: false

      t.timestamps
    end
  end
end
