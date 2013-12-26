require 'sinatra'
require 'sinatra/json'
require 'rake'

set :port, 3010
set :json_content_type, :js

get '/version' do
  version = `egison --version`.chop
  ret = { version: version }
  json ret
end

post '/eval/?' do
  File.write("programs/test.egi", params[:program])
  output = `egison programs/test.egi`.chop
  ret = { output: output }
  json ret
end
