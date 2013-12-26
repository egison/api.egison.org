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
