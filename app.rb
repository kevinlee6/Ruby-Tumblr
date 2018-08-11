require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'

set :database, {adapter: 'postgresql', database: 'microblog'}

get '/' do
  erb :index
end

get '/login' do
  erb :login
end