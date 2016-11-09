class AddValueToOption < ActiveRecord::Migration[5.0]
  def change
    add_column :options, :value, :integer
  end
end
