class AddOptionsToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :option_a, :string
    add_column :questions, :option_b, :string
  end
end
