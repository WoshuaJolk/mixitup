require 'ruby/openai'

class RecipesController < ApplicationController
  def show
    temp_recipe = Recipe.find(params[:id])
    
    openai = OpenAI::Client.new(access_token: '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')
    # prompt = "Give me a native recipe title, measured ingredients, and numbered instructions of a distinct '#{temp_recipe.origin}' cuisine
    #           that uses the following ingredients: '#{temp_recipe.ingredients}'. The returned recipe should be in JSON format with 
    #           three parameters 'title' and 'ingredients' and 'instructions' "
    # prompt = "Give me the recipe to a '#{temp_recipe.origin}' dish with '#{temp_recipe.ingredients}'. The returned recipe should be in JSON format with 
    # #           three parameters 'title' and 'ingredients' and 'instructions'"
    prompt = "Give me a '#{temp_recipe.origin}' dish with '#{temp_recipe.ingredients}'. Avoid making up dishes or lying. The returned recipe should be in JSON format with 
    three parameters 'title' (which is the dish's native name) and 'ingredients' and 'instructions'"
    response = openai.completions(
      parameters: {
        model: "text-davinci-003",
        prompt: prompt,
        temperature: 0.1,
        max_tokens: 500,
     }
    )
    json_response = JSON.parse(response['choices'][0]['text'].lstrip)
    
    temp_recipe.title = json_response["title"]
    temp_recipe.requirements = json_response["ingredients"].join("\n")
    temp_recipe.instructions = json_response["instructions"].join("\n")

    @recipe = temp_recipe
  end

  def new
    @recipe=Recipe.new
  end

  def create
    @recipe = Recipe.new(ingredients: params[:recipe][:ingredients], origin: params[:recipe][:origin],
                         title: "...", instructions: "...", requirements: "...")
    if @recipe.save
      redirect_to @recipe
    else
      render :new, status: :unprocessable_entity
    end
  end
end
