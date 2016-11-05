class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.integer :leader_id
      t.string :name
      t.string :company

      t.timestamps
    end
  end
end
