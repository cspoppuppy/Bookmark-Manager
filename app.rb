require 'sinatra'
require_relative 'db_connect_setup'
require_relative './lib/bookmark'
require_relative './lib/tag'
require_relative './lib/user'
require 'sinatra/flash'
require 'uri'

class BookmarkManager < Sinatra::Base
    enable :sessions, :method_override
    register Sinatra::Flash
  # configure :development do
  #   register Sinatra::Reloader
  # end

  get '/bookmarks' do
    @user = User.find(session[:user_id])
    @bookmarks = Bookmark.items
    @tags = Tag.items
    erb(:'/bookmarks/index')
  end

  get '/bookmarks/new' do
    erb(:'/bookmarks/new')
  end

  post '/bookmarks' do
    flash[:error] = "Invalid URL" unless Bookmark.add(params[:url], params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(params[:id])
    erb(:'/bookmarks/update')
  end

  put '/bookmarks/:id' do
    Bookmark.update(params[:id], params[:title], params[:url])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/comments/new' do
    @id = params[:id]
    erb(:'/comments/new')
  end

  post '/bookmarks/:id/comments' do
    @bookmark = Bookmark.find(params[:id])
    @bookmark.add_comment(params[:comment])
    redirect '/bookmarks'
  end

  get '/tags/new' do
    erb(:'/tags/index')
  end

  post '/tags' do
    Tag.add(params[:content])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/tags/new' do
    @id = params[:id]
    @tags = Tag.items
    erb(:'/tags/new')
  end

  post '/bookmarks/:id/tags' do
    @bookmark = Bookmark.find(params[:id])
    @bookmark.add_tag(params[:tag])
    redirect '/bookmarks'
  end

  get '/tags/:id/bookmarks' do
    @bookmarks = Tag.find(params[:id]).bookmarks
    erb(:'/tags/bookmarks')
  end

  get '/users/new' do
    erb(:'/users/new')
  end

  post '/users' do
    user = User.create(params[:email], params[:password])
    session[:user_id] = user.id
    redirect '/bookmarks'
  end

  get '/sessions/new' do
    erb(:'sessions/new')
  end

  post '/sessions' do
    user = User.sign_in(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect('/bookmarks')
    else
      flash[:error] = 'Please check your email or password.'
      redirect('/sessions/new')
    end
  end

  post '/sessions/destroy' do
    session.clear
    flash[:error] = "You have signed out."
    redirect('/bookmarks')
  end

  run! if app_file == $0
end
