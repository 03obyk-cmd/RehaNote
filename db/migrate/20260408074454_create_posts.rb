class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :community, null: false, foreign_key: true
      t.string :title
      t.integer :start_position
      t.text :exercise_description
      t.text :record_example

      t.timestamps
    end
  end
end
