json.array! @places do |place|
  json.extract! place, :id, :destination_id, :name, :stars, :banner, :photo
end
