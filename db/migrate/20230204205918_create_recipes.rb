class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :ingredients
      t.string :origin
      t.string :recipes

      t.timestamps
    end
  end
end
