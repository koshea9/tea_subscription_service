class CreateTeas < ActiveRecord::Migration[6.1]
  def change
    create_table :teas do |t|
      t.string :title
      t.string :description
      t.integer :rating
      t.integer :temperature
      t.integer :brew_time
      t.string :image

      t.timestamps
    end
  end
end
