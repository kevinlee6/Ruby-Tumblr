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
  email = params[:email]

  if session[:user_id]
    session[:user_id] = nil
  elsif Validate.login(email, params[:password])
    @user = User.find_by(email: email)
    session[:user_id] = @user.id
    flash[:info] = "You have successfully logged in, #{@user.firstname}."
  else
    flash[:warning] = 'Invalid username or password.'
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
  email = params[:email]
  password = params[:password]
  reenter_password = params[:reenter_password]
  birthday = params[:birthday]
  @validate = Validate.register(email, password, reenter_password, birthday)

  if User.find_by(email: email)
    flash[:warning] = 'That email is already taken.'
    redirect '/signup'
  elsif @validate == true
    User.create(
      email: email,
      password: password,
      firstname: params[:firstname],
      lastname: params[:lastname],
      birthday: birthday
    )
    erb :signup
  else
    flash[:warning] = @validate
    redirect '/signup'
  end
end