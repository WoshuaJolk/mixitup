class RecipesController < ApplicationController
  def show
    temprecipe = Recipe. find(params[:id])
    # Use Ai to update the hashmap here
    @recipe = temprecipe
  end

  def new
    @recipe=Recipe.new
  end

  def create
    @recipe = Recipe.new(ingredients: params[:recipe][:ingredients], origin: params[:recipe][:origin], response: "...")
    if @recipe.save
      redirect_to @recipe
    else
      render :new, status: :unprocessable_entity
    end
  end
end
