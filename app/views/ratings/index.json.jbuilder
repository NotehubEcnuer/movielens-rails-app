json.array!(@ratings) do |rating|
  json.extract! rating, :id, :user_id, :movie_id, :rating, :rated_at
  json.url rating_url(rating, format: :json)
end
