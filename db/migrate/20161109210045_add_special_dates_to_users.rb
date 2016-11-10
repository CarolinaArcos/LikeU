class AddSpecialDatesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :started_at, :datetime
    add_column :users, :answered_at, :datetime
  end
end
