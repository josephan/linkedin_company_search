require 'sinatra'

get '/' do
  "Hello linkedin user! Your access code is: #{params["code"]}"
end
