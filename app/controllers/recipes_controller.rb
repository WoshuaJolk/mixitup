class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe=Recipe.new
  end

  def create
    @recipe = Recipe.new(ingredients: "...", origin: "...", response: "...")
    if @recipe.save
      redirect_to @recipe
    else
      render :new, status: :unprocessable_entity
    end
  end
end
