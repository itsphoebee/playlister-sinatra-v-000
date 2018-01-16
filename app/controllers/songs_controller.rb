require 'pry'
class SongsController < ApplicationController
  enable :sessions
  #use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  post '/songs' do
    @song = Song.create(name:params[:name])
    genre = Genre.find(params[:song][:genres])
    artist = Artist.find_by(name:params[:artist][:name])
    if !!artist
      @song.artist = artist
    else
      @song.artist = Artist.create(name:params[:artist][:name])
      @song.save
    end
    #flash[:message] = "Successfully created song."
    redirect to("/songs/#{@song.slug}")
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

end
