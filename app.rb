# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/nametest' do
    @name = params[:name]

    return erb(:nametest)
  end

  get '/' do
    return erb(:index)
  end

  get '/about' do
    return erb(:about)
  end

  get '/albums/new' do
    return erb(:new_album)
  end

  get '/artists/new' do
    return erb(:new_artist)
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
   
      response = @albums.map do |album|
      @title = album.title
      @release_year = album.release_year
      @id = album.artist_id
      album
    end
      return erb(:albums)
    end 

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all

      response = @artists.map do |artist|
      @name = artist.name
      @genre = artist.genre
      @id = artist.id
      artist
    end

    return erb(:artists)
  end

  get '/albums/:id' do
    id = params[:id]

    repo = AlbumRepository.new
    album = repo.find(id)
    @title = album.title
    @release_year = album.release_year

    artist_repo = ArtistRepository.new
    artist = artist_repo.find(album.artist_id)
    @artist_name = artist.name

    return erb(:album)
  end

  get '/artists/:id' do
    id = params[:id]

    repo = ArtistRepository.new
    artist = repo.find(id)
    @name = artist.name
    @genre = artist.genre

    return erb(:artist)
  end

   post '/albums' do
    if params[:title] == nil || params[:release_year] == nil || params[:artist_id] == nil
      status 400
      return ''
    end

    repo = AlbumRepository.new
    new_album = Album.new
  
    new_album.title = params[:title]
    new_album.release_year = params[:release_year]
    new_album.artist_id = params[:artist_id]
  
    repo.create(new_album)
  
    return ''
   end

   post '/albums' do
    @album_name = params[:album_name]
    return erb(:album_added)
   end


  post '/artists' do
    repo = ArtistRepository.new
    new_artist = Artist.new

    new_artist.name = params[:name]
    new_artist.genre = params[:genre]

    repo.create(new_artist)

    return erb(:artist_added)
  end
end

