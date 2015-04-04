json.array!(@genres_movies) do |genres_movie|
  json.extract! genres_movie, :id, :movie_id, :genre_id
  json.url genres_movie_url(genres_movie, format: :json)
end
