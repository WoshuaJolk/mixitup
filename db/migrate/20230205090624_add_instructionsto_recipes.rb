class AddInstructionstoRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :instructions, :string
    add_column :recipes, :requirements, :string
    rename_column :recipes, :response, :title
  end
end
