class AddCompleteInDaysToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :complete_in_days, :integer
  end
end
