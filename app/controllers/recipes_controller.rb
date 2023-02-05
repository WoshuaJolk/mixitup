require 'ruby/openai'

class RecipesController < ApplicationController
  def show
    temp_recipe = Recipe.find(params[:id])
    
    openai = OpenAI::Client.new(access_token: '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')
    prompt = "Come up with a food recipe from '#{temprecipe.origin}'
              that uses the following ingredients: '#{temprecipe.ingredients}'"
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
                         title: "...", instructions: "...", response: "...")
    if @recipe.save
      redirect_to @recipe
    else
      render :new, status: :unprocessable_entity
    end
  end
end
