class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.text :body
      t.integer :question_id

      t.timestamps
    end
    add_index :options, :question_id
  end
end
