class CreateIssues < ActiveRecord::Migration[7.1]
  def change
    create_table :issues do |t|
      t.references :newsletter, null: false, foreign_key: true
      t.string :subject, null: false
      t.text :content, null: false
      t.datetime :published_at

      t.timestamps
    end
  end
end
