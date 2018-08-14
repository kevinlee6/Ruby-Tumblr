require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra/reloader'
require_relative 'validate'

require './models/user'
require './models/post'

enable :sessions

set :database, {adapter: 'postgresql', database: 'rumblr'}

get '/' do
  begin
    @posts = User.find(session[:user_id]).posts
  rescue
    @posts = nil
  end
  erb :index
end

post '/' do
  email = params[:email]

  if session[:user_id]
    session[:user_id] = nil
  elsif Validate.login(email, params[:password])
    @user = User.find_by(email: email.downcase)
    session[:user_id] = @user.id
    flash[:info] = "You have successfully logged in, #{@user.firstname}."
  else
    flash[:warning] = 'Invalid username or password.'
  end

  redirect '/'
end

get '/user/:id' do
  begin
    @posts = User.find(params[:id]).posts
  rescue
    flash[:warning] = 'There are no posts associated with this user!'
    redirect '/'
  end
  erb :posts
end

get '/user/:id/posts' do
  begin
    @posts = User.find(params[:id]).posts
  rescue
    flash[:warning] = 'There is no post id associated with this user!'
    redirect '/'
  end
  erb :posts
end

get '/user/:user_id/posts/:id' do
  begin
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    if @user.id == @post.user_id
      erb :show_post
    else
      raise 'error'
    end
  rescue
    flash[:warning] = 'There is no post id associated with this user!'
    redirect "/user/#{params[:user_id]}/posts"
  end
end

get '/user/posts/new' do
  erb :new_post
end

post '/posts' do
  content = params[:content].gsub(/\r?\n/, '<br />')
  Post.create(
    title: params[:title],
    content: content,
    user_id: session[:user_id],
    image_url: params[:image_url],
    datetime: Time.now.utc
  )

  redirect '/user/posts'
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

  if User.find_by(email: email.downcase)
    flash[:warning] = 'That email is already taken.'
    redirect '/signup'
  elsif @validate == true
    User.create(
      email: email.downcase,
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