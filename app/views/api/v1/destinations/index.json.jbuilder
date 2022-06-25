json.array! @destinations do |destination|
  json.extract! destination, :id, :name, :region, :photo, :banner
end
