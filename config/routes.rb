Rails.application.routes.draw do

	#Obtener
	get '/artists' => 'artists#index'

	get '/artists/:artist_id' => 'artists#show'

	get '/artists/:artist_id/albums' => 'albums#show_by_artist'

	get '/artists/:artist_id/tracks' => 'tracks#show_by_artist'

	get '/albums' => 'albums#index'

	get '/albums/:album_id' => 'albums#show'

	get '/albums/:album_id/tracks' => 'tracks#show_by_album'

	get '/tracks' => 'tracks#index'

	get '/tracks/:track_id' => 'tracks#show'


	#Crear
	post 'artists' => 'artists#create'

	post "/artists/:artist_id/albums" => 'albums#create'

	post "/albums/:album_id/tracks" => 'tracks#create'

	#Eliminar

	delete '/artists/:artist_id' => 'artists#destroy'

	delete '/albums/:album_id' => 'albums#destroy'

	delete '/tracks/:track_id' => 'tracks#destroy'

	#Reproducir

	put '/artists/:artist_id/albums​/play' => 'artists#update'#Reproduce todas las canciones de un artista

	put '/albums/:album_id/tracks​/play' => 'albums#update'#Reproduce todas las canciones de un álbum

	put '/tracks/:track_id/play' => 'tracks#update'#Reproduce una canción


end
