class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.string :title
      t.text :description
      t.integer :max_players

      t.timestamps
    end
  end
end
