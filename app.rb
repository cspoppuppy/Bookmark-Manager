require 'sinatra'
require_relative './lib/bookmark'
require_relative 'db_connect_setup'
require 'sinatra/flash'
require 'uri'

class BookmarkManager < Sinatra::Base
    enable :sessions, :method_override
    register Sinatra::Flash
  # configure :development do
  #   register Sinatra::Reloader
  # end

  get '/bookmarks' do
    @bookmarks = Bookmark.items
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

  run! if app_file == $0
end
