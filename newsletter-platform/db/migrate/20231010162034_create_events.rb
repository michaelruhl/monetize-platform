class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.json :data
      t.string :source
      t.text :processing_errors
      t.integer :status

      t.timestamps
    end
  end
end
