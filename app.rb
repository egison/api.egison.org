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
  filename = "programs/" + Time.now.strftime("%Y-%m-%d-%H-%M-%S-%L");
  File.write(filename, params[:program])
  output = `timeout 5 egison --no-io -l #{filename} 2>&1`.chop
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

get '/tutorial' do
  output = `egison-tutorial -s #{params[:sn]} -c #{params[:ssn]} 2>&1`.chop
  ret = { output: output }
  json ret
end

get '/tutorial/table' do
  output = `egison-tutorial -l 2>&1`.chop
  ret = { output: output }
  json ret
end
