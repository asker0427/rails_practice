class AddCurrentPlayerOrderToGames < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :current_player_order, :integer, default: 0
  end
end
