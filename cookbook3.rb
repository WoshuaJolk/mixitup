require 'ruby/openai'

openai = OpenAI::Client.new(access_token: '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')

ilist = "water, noodles, salt"

place = "Italy"

prompt = "Come up with a recipe title, measured ingredients, and numbered            instructions of cuisine from '#{place}'
        that uses the following ingredients: '#{ilist}'.
        The returned recipe should be in JSON format with
        three parameters 'title' and 'ingredients' and 'instructions'"

response = openai.completions(
 parameters: {
   model: "text-davinci-003",
   prompt: prompt,
   temperature: 0.1,
   max_tokens: 500,
 }
)

jsonResponse = JSON.parse(response['choices'][0]['text'].lstrip)

puts "#{jsonResponse}"
puts "Title: #{jsonResponse["title"]}"
puts "Ingredients: \n#{jsonResponse["ingredients"].join("\n")}"
puts "Instructions: \n#{jsonResponse["instructions"].join("\n")}"
