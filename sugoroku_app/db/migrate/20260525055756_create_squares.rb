class CreateSquares < ActiveRecord::Migration[8.1]
  def change
    create_table :squares do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :position
      t.string :square_type
      t.string :text
      t.string :effect
      t.integer :value

      t.timestamps
    end
  end
end
