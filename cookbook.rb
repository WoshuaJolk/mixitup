require 'ruby/openai'

openai = OpenAI::Client.new(access_token: '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')

ilist = "water, noodles, salt"

place = "Italy"

prompt = "Come up with a food recipe from '#{place}'
          that uses the following ingredients: '#{ilist}'"

response = openai.completions(
 parameters: {
   model: "text-davinci-003",
   prompt: prompt,
   temperature: 0.1,
   max_tokens: 500,
 }
)

puts response['choices'][0]['text']
