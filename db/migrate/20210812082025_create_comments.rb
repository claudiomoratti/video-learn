class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :lesson, null: false, foreign_key: true
      t.string :author
      t.text :content
      t.integer :reported_count

      t.timestamps
    end
  end
end
