class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/books'
    end
  end

  post '/signup' do
    if params.values.any? {|value| value == ""}
      erb :'users/signup', locals: {message: "You can't do that!"}
    else
      @user = User.new(firstname: params[:firstname],lastname: params[:lastname], email: params[:email], password: params[:password],avatar: params[:avatar],about_me: params[:about_me])
      @user.save
      session[:user_id] = @user.id
      redirect to '/books'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/books'
    end
  end

  post '/login' do
    user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/books'
    else
      erb :'users/login', locals: {message: "Your credentials are incorrect!"}
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/'
    else
      redirect to '/books'
    end
  end

end
