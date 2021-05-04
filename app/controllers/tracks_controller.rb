require "base64"

class TracksController < ApplicationController
	def index
    	t = []
		x = 0
    	Track.all.each do |tracks|
		    aux_artists = $path + 'artists/' + tracks.artist_id
		    aux_self = $path + 'tracks/' +  tracks.track_id
		    aux_albums = $path + 'albums/' +  tracks.album_id
	    	a = {}
    		a = { id: tracks.track_id, album_id: tracks.album_id,name: tracks.name, duration: tracks.duration, times_played: tracks.times_played,artist: aux_artists, albums: aux_albums, self: aux_self}
			t[x]= a
    		x= x+1
    	end

		render json: t 
  	end
  	
	def show
  		tracks= Track.find_by(track_id: params[:track_id])
	    aux_artists = $path + 'artists/' + tracks.artist_id
	    aux_self = $path + 'tracks/' +  tracks.track_id
	    aux_albums = $path + 'albums/' + tracks.album_id

		render json: { id: tracks.track_id, album_id: tracks.album_id ,name: tracks.name, duration: tracks.duration, times_played: tracks.times_played,artist: aux_artists, albums: aux_albums, self: aux_self}
	end

	def show_by_artist
		trackX = Track.where(:artist_id   =>  params[:artist_id])
    	t = []
		x = 0
    	trackX.each do |tracks|
		    aux_artists = $path + 'artists/' + tracks.artist_id
		    aux_self = $path + 'tracks/' +  tracks.track_id
		    aux_albums = $path + 'albums/' +  tracks.album_id
	    	a = {}
    		a = { id: tracks.track_id, album_id: tracks.album_id,name: tracks.name, duration: tracks.duration, times_played: tracks.times_played,artist: aux_artists, albums: aux_albums, self: aux_self}
			t[x]= a
    		x= x+1
    	end

		render json: t 
	end

	def show_by_album
		albumX = Track.where(:album_id   =>  params[:album_id])
    	t = []
		x = 0
    	albumX.each do |tracks|
		    aux_artists = $path + 'artists/' + tracks.artist_id
		    aux_self = $path + 'tracks/' +  tracks.track_id
		    aux_albums = $path + 'albums/' +  tracks.album_id
	    	a = {}
    		a = { id: tracks.track_id, album_id: tracks.album_id,name: tracks.name, duration: tracks.duration, times_played: tracks.times_played,artist: aux_artists, albums: aux_albums, self: aux_self}
			t[x]= a
    		x= x+1
    	end

		render json: t 
	end

  	def create
  		create_params = tracks_params 
  		albumX = Album.find_by(album_id: params[:album_id])
	    aux_name = create_params[:name] 
	    aux_album_id = params[:album_id] 
	    aux_name = aux_name  + ":" + aux_album_id
	    encoded = Base64.strict_encode64(aux_name)
	   	encoded = encoded[0...22]
	    create_params[:track_id] = encoded
	    create_params[:times_played] = 0
	    create_params[:album_id] = params[:album_id]
	    create_params[:artist_id] = albumX.artist_id
	    tracks = Track.create(create_params)
	    aux_artists = $path + 'artists/' + albumX.artist_id
	    aux_self = $path + 'tracks/' +  encoded
	    aux_albums = $path + 'albums/' + params[:album_id]
	 
		render json: { id: tracks.track_id, album_id: tracks.album_id ,name: tracks.name, duration: tracks.duration, times_played: tracks.times_played,artist: aux_artists, albums: aux_albums, self: aux_self}
	end


	def update#Reproduce una canción
	tracks= Track.find_by(track_id: params[:track_id])
		if tracks != nil
	  		t = 0
	  		t = tracks.times_played + 1
			tracks.update(times_played:   t)
		  	render :status => "204", :json => {:message =>"canción reproducida"}.to_json
		else
		  	render :status => "404", :json => {:description => "canción no encontrada"}.to_json
		end

	end

	def destroy
	  track =  Track.find_by(track_id: params[:track_id])
	  if track != nil
	  	if track.delete()
	  		msg = "album eliminado"
	  		render :status => "204", :json => msg.to_json
		else
			render :status => "404", :json => {:status => "album inexistente"}.to_json
		end
	  else
	  	render :status => "404", :json => {:description => "album inexistente"}.to_json
	  end

	end

		private 

	def tracks_params
	  params.require(:track).permit(:name, :duration)
	end

end