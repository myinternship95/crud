class BooksController < ApplicationController
  get '/books' do
    if logged_in?
      @books = Book.all
      erb :'books/index'
    else
      erb :'users/login', locals: {message: "You don't have access, please login"} 
    end
  end

  get '/books/new' do
    if logged_in?
      erb :'books/new'
    else
      erb :'users/login', locals: {message: "You don't have access, please login"}
    end
  end

  post '/books' do
    if params.values.any? {|value| value == ""}
      erb :'books/new', locals: {message: "Your missing information!"}
    else
      user = User.find(session[:user_id])
      @book = Book.create(title: params[:title], authors: params[:authors], publisher: params[:publisher], year: params[:year], user_id: user.id)
      redirect to "/books/#{@book.id}"
    end
  end

  get '/books/:id' do 
    if logged_in?
      @book = Book.find(params[:id])
      erb :'books/show'
    else 
      erb :'users/login', locals: {message: "You don't have access, please login"}
    end
  end

  get '/books/:id/edit' do
    if logged_in?
      @book = Book.find(params[:id])
      if @book.user_id == session[:user_id]
       erb :'books/edit'
      else
      erb :'books', locals: {message: "You don't have access to edit this book"}
      end
    else
      erb :'users/login', locals: {message: "You don't have access, please login"}
    end
  end

  patch '/books/:id' do 
    if params.values.any? {|value| value == ""}
      @book = Book.find(params[:id])
      erb :'books/edit', locals: {message: "You're missing information"}
      redirect to "/books/#{params[:id]}/edit"
    else
      @book = Book.find(params[:id])
      @book.title = params[:title]
      @book.authors = params[:authors]
      @book.publisher = params[:publisher]
      @book.year = params[:year]
      @book.save
      redirect to "/books/#{@book.id}"
    end
  end

  delete '/books/:id/delete' do 
    @book = Book.find(params[:id])
    if session[:user_id]
      @book = Book.find(params[:id])
      if @book.user_id == session[:user_id]
        @book.delete
        redirect to '/books'
      else
        redirect to '/books'
      end
    else
      redirect to '/login'
    end
  end

end
