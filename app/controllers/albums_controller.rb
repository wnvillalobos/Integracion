require "base64"

class AlbumsController < ApplicationController
	def index
		t = []
		x = 0
    	Album.all.each do |albums|
	    	aux_artists = $path + 'artists/' + albums.artist_id.to_s
	    	aux_self = $path + 'albums/' +  albums.album_id
	    	tracks = aux_self + '/tracks'
	    	a = {}
    		a = {id: albums.album_id, artist_id: albums.artist_id,name: albums.name, genre: albums.genre, artist: aux_artists, tracks: tracks, self: aux_self}#, include: [:name, :age, :artist_id]
    		t[x]= a
    		x= x+1
    	end

		render  json: t
  	end

	def show
	    album =  Album.find_by(album_id: params[:album_id])
	    aux_artists = $path + 'artists/' + params[:artist_id]
	    aux_self = $path + 'albums/' + encoded
	    tracks = aux_self + '/tracks'

	    render json: { id: :album_id, artist_id: album.artist_id,name: album.name, genre: album.genre, artist: aux_artists, tracks: tracks, self: aux_self}#, include: [:name, :age, :artist_id]

	end


	def show_by_artist
		albumX = Album.find_by(artist_id: artist.artist_id)
	    render json: albumX
	end


  	def create

  		artistX = Artist.find_by(artist_id: params[:artist_id])
  		create_params = albums_params 
	    aux_name = create_params[:name] 
	    aux_artist_id = params[:artist_id]
	    aux_name = aux_name + ":" + aux_artist_id
	    encoded = Base64.strict_encode64(aux_name)
	    encoded = encoded[0...22]
	    create_params[:album_id] = encoded
	    create_params[:artist_id] = params[:artist_id]
	    albums = Album.create(create_params)
	    aux_artists = $path + 'artists/' + params[:artist_id]
	    aux_self = $path + 'albums/' + encoded
	    tracks = aux_self + '/tracks'

		render json: { id: encoded, artist_id: params[:artist_id],name: albums.name, genre: albums.genre, artist: aux_artists, tracks: tracks, self: aux_self}#, include: [:name, :age, :artist_id]
	
	end



	def update#Reproduce todas las canciones de un álbum
		trackX = Track.where(:album_id   =>  params[:album_id])
		if trackX != nil
		  	trackX.each do |tracks|
		  		t = 0
		  		t = tracks.times_played + 1
				tracks.update(times_played:   t)
			end
		  	render :status => "204", :json => {:message =>"	canciones del álbum reproducidas"}.to_json
		else
		  	render :status => "404", :json => {:description => "álbum no encontrado"}.to_json
		end
	end

	def destroy
	  album =  Album.find_by(album_id: params[:album_id])
	  if album != nil
	  	if album.delete()
	  		render :status => "204", :json => {:message =>"album eliminado"}.to_json
		else
			render :status => "404", :json => {:status => "album inexistente"}.to_json
		end
	  else
	  	render :status => "404", :json => {:description => "album inexistente"}.to_json
	  end

	end
	private 

	def albums_params
	  params.require(:album).permit(:name, :genre)
	end
end
