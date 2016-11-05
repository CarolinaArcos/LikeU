class RemoveQuestionIdFromAnswers < ActiveRecord::Migration[5.0]
  def change
    remove_column :answers, :question_id, :integer
  end
end
