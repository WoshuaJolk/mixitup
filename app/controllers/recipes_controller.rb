require 'ruby/openai'

class RecipesController < ApplicationController
  def show
    temprecipe = Recipe. find(params[:id])
    
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
    temprecipe.response = response['choices'][0]['text']
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
