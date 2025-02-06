require "dotenv/load"
require "http"
require "sinatra"
require "sinatra/reloader"
require "json"

get("/") do
forex_api_key=ENV.fetch("FOREX_KEY")
forex_url="https://api.exchangerate.host/list?access_key=#{forex_api_key}"
@raw_response = HTTP.get(forex_url)
@string_response = @raw_response.to_s
@parsed_response = JSON.parse(@string_response)
@currencies= @parsed_response.fetch("currencies")
  erb(:homepage)
end


get("/:from_currency") do
  @original_currency = params.fetch("from_currency")

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("FOREX_KEY")}"
  @raw_response = HTTP.get(api_url)
  @string_response = @raw_response.to_s
  @parsed_response = JSON.parse(@string_response)
  @currencies= @parsed_response.fetch("currencies")
  erb(:from_currency)
end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")

  api_url = "https://api.exchangerate.host/convert?access_key=#{ENV.fetch("FOREX_KEY")}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
  @raw_response = HTTP.get(api_url)
  @string_response = @raw_response.to_s
  @parsed_response = JSON.parse(@string_response)
 @result=@parsed_response.fetch("result")


  erb(:from_to_currency)
end
