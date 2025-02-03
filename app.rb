require "sinatra"
require "sinatra/reloader"
require "http"
require "json"
require 'dotenv'

Dotenv.load

key = ENV["EXCHANGE_RATE_KEY"]


get("/") do

  exchange_url = "https://api.exchangerate.host/list?access_key=" + key

  raw_response = HTTP.get(exchange_url)

  parsed_response = JSON.parse(raw_response)

  currencies_list = parsed_response.fetch("currencies").keys

  @currencies = currencies_list

  erb(:homepage)
end

get "/:from/:to" do
  @from = params[:from]
  @to = params[:to]
  
  conversion_url = "https://api.exchangerate.host/convert?from=#{@from}&to=#{@to}&amount=1&access_key=#{key}"
  raw_conversion = HTTP.get(conversion_url)
  parsed_conversion = JSON.parse(raw_conversion)
  @amount = parsed_conversion["result"]

  erb :conversion
end

get "/:current" do

  exchange_url = "https://api.exchangerate.host/list?access_key=" + key

  raw_response = HTTP.get(exchange_url)

  parsed_response = JSON.parse(raw_response)

  currencies_list = parsed_response.fetch("currencies").keys

  @currencies = currencies_list

  @current = params[:current]
  @currencies = currencies_list
  
  erb :convert
end
