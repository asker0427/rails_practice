class CreatePlayers < ActiveRecord::Migration[8.1]
  def change
    create_table :players do |t|
      t.references :game, null: false, foreign_key: true
      t.string :name
      t.integer :position
      t.boolean :is_goal
      t.integer :skip_turns
      t.integer :rank
      t.integer :turn_order

      t.timestamps
    end
  end
end
