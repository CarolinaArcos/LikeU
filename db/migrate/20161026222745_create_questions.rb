class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :header
      t.string :kind
      t.integer :section_id

      t.timestamps
    end
    add_index :questions, :section_id
  end
end
