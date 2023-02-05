class RenameRecipesInRecipes < ActiveRecord::Migration[6.1]
  def change
    rename_column :recipes, :recipes, :response 
  end
end
