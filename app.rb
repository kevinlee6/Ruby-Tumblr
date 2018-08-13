require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'

set :database, {adapter: 'postgresql', database: 'rumblr'}

get '/' do
  erb :index
end

post '/' do
  redirect '/'
end

get '/login' do
  erb :login
end