require 'pry'
class SongsController < ApplicationController
  enable :sessions
  user Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  post '/songs' do
    binding.pry
    @song = Song.create(name:params[:name])
    artist = Artist.find_by_name(name:params[:artist][:name])
    if !!artist
      @song.artist = artist
    else
      @song.artist = Artist.create(name:params[:artist][:name])
      @song.save
    end
    redirect '/songs/:slug'
  end

end
