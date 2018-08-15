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
    @posts = Post.all
    @users = @posts.each do |post|
      User.find(post.user_id)
    end
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
    @user = User.find(params[:id])
    @posts = @user.posts
  rescue
    flash[:warning] = 'There are no posts associated with this user!'
    redirect '/'
  end
  erb :posts
end

get '/user/:id/posts' do
  begin
    @user = User.find(params[:id])
    @posts = @user.posts
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
  title = params[:title]
  validate = Validate.post(title)
  if validate == true
    Post.create(
      title: title,
      content: params[:content],
      user_id: session[:user_id],
      image_url: params[:image_url],
      datetime: Time.now.utc
    )
  else
    flash[:warning] = validate
  end

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
  firstname = params[:firstname]
  lastname = params[:lastname]
  birthday = params[:birthday]
  @validate = Validate.register(email, password, reenter_password, firstname, lastname, birthday)

  if User.find_by(email: email.downcase)
    flash[:warning] = 'That email is already taken.'
    redirect '/signup'
  elsif @validate == true
    User.create(
      email: email.downcase,
      password: password,
      firstname: firstname,
      lastname: lastname,
      birthday: birthday
    )
    erb :signup
  else
    @errors = [@validate.slice!(0)]
    @validate.each do |x|
      @errors << x
    end
    flash[:warning] = @errors.join('<br />')
    redirect '/signup'
  end
end