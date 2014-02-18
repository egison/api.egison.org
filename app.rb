require 'sinatra'
require 'sinatra/json'
require 'rake'
require 'github_api'
require 'open-uri'

set :port, 3010
set :json_content_type, :js

get '/version' do
  version = `egison --version`.chop
  ret = { version: version }
  json ret
end

post '/eval/?' do
  File.write("programs/test.egi", params[:program])
  output = `timeout 5 egison -l programs/test.egi 2>&1`.chop
  if $?.exitstatus == 124
    output = "Timeout. We are limiting the resource for the online interprter."
  end
  ret = { output: output }
  json ret
end

get '/github' do
  github = Github.new
  response = github.repos.get("egisatoshi", "egison/contents/" + params[:path])
  content = Base64.decode64(response.content)
  ret = { content: content }
  json ret
end

get '/source' do
  content = open("http://www.egison.org/source/" + params[:path]).read
  ret = { content: content }
  json ret
end
