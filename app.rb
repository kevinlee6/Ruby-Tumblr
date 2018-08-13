require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/reloader'
require_relative 'validate'

require './models/user'

enable :sessions

set :database, {adapter: 'postgresql', database: 'rumblr'}

get '/' do
  erb :index
end

post '/' do
  if Validate.login(params[:username], params[:password])
    sessions[:user_id] = true
    flash[:notice] = "You have successfully logged in, #{params[:username]}"
  else
    flash[:warning] = 'Invalid username or password'
  end
  redirect '/'
end

get '/login' do
  erb :login
end

get '/signup' do
  erb :signup
end

post '/signup' do
  username = params[:username]
  password = params[:password]
  reenter_password = params[:reenter_password]
  email = params[:email]
  @validate = Validate.register(email, password, reenter_password)

  if @validate == true
    User.create(
      email: email,
      password: password,
      firstname: firstname,
      lastname: lastname,
      birthday: birthday
    )
  else
    flash[:warning] = @validate
  end

  redirect '/signup'
end