require 'openai'

class OpenaiService
  def initialize
    OpenAI.api_key = ENV["OPENAI_API_KEY"]
  end

  def chat(message)
    response = OpenAI::ChatCompletion.create(
      model: "gpt-3.5-turbo",
      messages: [
        {
          role: "system",
          content: "You are a helpful assistant."
        },
        {
          role: "user",
          content: message
        }
      ]
    )
    response['choices'][0]['message']['content']
  end
end
