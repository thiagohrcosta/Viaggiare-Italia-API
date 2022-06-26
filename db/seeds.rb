require 'nokogiri'
require 'open-uri'
require 'uri'

Category.destroy_all
Destination.destroy_all
Place.destroy_all
BannerPlace.destroy_all
PhotoPlace.destroy_all
Place.destroy_all

array_of_categories = [
  "Ristoranti",
  "Alberghi",
  "Spiagge",
  "Vita noturna"
]

array_of_categories.each do |category|
  Category.create(name: category)
end

puts "Categories created with success!"
puts "==============================="



banner_image_array = []

banner_image = Nokogiri::HTML(URI.open("https://unsplash.com/collections/3x2_s_xw0f0/destinationbanner"))
banner_image.css("figure a img").each do |banner|
  image_banner = banner.values[3].split
  next if image_banner[26].nil?

  banner_image_array << image_banner[26]
end

photo_image_array = []

photo_image =  Nokogiri::HTML(URI.open("https://unsplash.com/collections/yBTX506UD_8/destinationcard"))
photo_image.css("figure a img").each do |photo|
  image_photo = photo.values[3].split
  next if image_photo[14].nil?

  photo_image_array << image_photo[14]
end

puts "Creating Destinations..."
## Adds destinations to the database

doc_destinations = Nokogiri::HTML(URI.open("https://www.britannica.com/topic/list-of-cities-and-towns-in-Italy-2047404"))
puts "Url successfully opened!"
doc_destinations.css("section").each do |destination|
  puts "Url scrapped"
  region = destination.css("h2").text
  destination.css("ul li a").each do |place|
    city = place.children.text

    Destination.create(
      name: city,
      region: region,
      banner: banner_image_array.sample,
      photo: photo_image_array.sample
    )
  end
  puts "Destination created with success!"
end

puts "Destinations created with success! #{Destination.count}"


puts "Adding Banner Places..."

place_image_banner_array = []

doc_banner = Nokogiri::HTML(URI.open("https://unsplash.com/collections/K4_v8gc61jw/italianbanner"))
doc_banner.css('figure a img').each do |img|
  search_array = img.values[3].split
  next if search_array[26].nil?

  url = search_array[26]
  place_image_banner_array << url

  break if place_image_banner_array.size > 56
end

puts "Adding Photo Places..."
place_image_photo_array = []

doc_photo = Nokogiri::HTML(URI.open("https://unsplash.com/collections/9FKBTb41_jU/italian"))
doc_photo.css('figure a img').each do |img|
  search_array = img.values[3].split
  next if search_array[14].nil?

  url = search_array[14]
  place_image_photo_array << url

  break if place_image_photo_array.size > 56
end

puts "Creating places..."
doc_places = Nokogiri::HTML(URI.open('https://www.forketers.com/120-italian-restaurant-names-will-amaze-even-italians/'))

doc_places.css('ol li').each do |places|
  Place.create(
    name:  places.children[0].text.capitalize,
    stars: rand(1..5),
    destination_id: rand(1..10),
    photo: place_image_banner_array.sample,
    banner: place_image_photo_array.sample
  )
end
