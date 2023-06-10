require 'net/http'
require 'uri'
require 'json'

class OpenaiService
  def initialize
    @api_key = ENV["OPENAI_API_KEY"]
  end

  def chat(message)
    uri = URI.parse("https://api.openai.com/v1/engines/davinci-codex/completions")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Authorization"] = "Bearer #{@api_key}"
    request.body = JSON.dump({
      "prompt" => message,
      "max_tokens" => 60
    })
  
    req_options = {
      use_ssl: uri.scheme == "https",
    }
  
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  
    json = JSON.parse(response.body)
    puts json # レスポンスの内容をログに出力
    json['choices'][0]['text'].strip
  end
end