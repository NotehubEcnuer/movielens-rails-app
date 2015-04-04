json.array!(@users) do |user|
  json.extract! user, :id, :age, :gender, :occupation_id, :zip_code
  json.url user_url(user, format: :json)
end
