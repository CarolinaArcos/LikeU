class AddFigureToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :figure, :string
  end
end
