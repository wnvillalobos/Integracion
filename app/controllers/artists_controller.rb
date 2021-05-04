require "base64"

class ArtistsController < ApplicationController

	def index
    	t = []
		x = 0
    	Artist.all.each do |artists|
		    aux_artists = $path + 'artists/' 
		    aux_artists = aux_artists + artists.artist_id
		    albums = aux_artists + '/albums'
		    tracks = aux_artists + '/tracks'
	    	a = {}
    		a = { id: artists.artist_id, name: artists.name, age: artists.age, albums: albums, tracks: tracks, self: aux_artists}
			t[x]= a
    		x= x+1
    	end

		render json: t 
  	end

	def show
		artist =  Artist.find_by(artist_id: params[:artist_id])
	    aux_artists = $path + 'artists/' 
	    aux_artists = aux_artists + artists.artist_id
	    albums = aux_artists + '/albums'
	    tracks = aux_artists + '/tracks'
	    
		render json: { id: artists.artist_id, name: artists.name, age: artists.age, albums: albums, tracks: tracks, self: aux_artists}
	end

  	def create
  		create_params = artists_params 
	    aux_name = create_params[:name]
	    encoded = Base64.strict_encode64(aux_name)
	   	encoded = encoded[0...22]
	    create_params[:artist_id] = encoded
	    artists = Artist.create(create_params)
	    aux_artists = $path + 'artists/' 
	    aux_artists = aux_artists + artists.artist_id
	    albums = aux_artists + '/albums'
	    tracks = aux_artists + '/tracks'

		render json: { id: artists.artist_id, name: artists.name, age: artists.age, albums: albums, tracks: tracks, self: aux_artists}
	end

	def update#Reproduce todas las canciones de un artista
		trackX = Track.where(:artist_id   =>  params[:artist_id])
		if trackX != nil
		  	trackX.each do |tracks|
		  		t = 0
		  		t = tracks.times_played + 1
				tracks.update(times_played:   t)
			end
		  	render :status => "204", :json => {:message =>"todas las canciones del artista fueron reproducidas"}.to_json
		else
		  	render :status => "404", :json => {:description => "artista inexistente"}.to_json
		end
	end

	def destroy
	  artist =  Artist.find_by(artist_id: params[:artist_id])
	  if artist != nil
	  	if artist.delete()
	  		render :status => "204", :json => {:message =>"artista eliminado"}.to_json
		else
			render :status => "404", :json => {:status => "artista inexistente"}.to_json
		end
	  else
	  	render :status => "404", :json => {:description => "artista inexistente"}.to_json
	  end

	end

	private 

	def artists_params
	  params.require(:artist).permit(:name, :age)
	end


end