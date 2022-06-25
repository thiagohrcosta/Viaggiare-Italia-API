require 'nokogiri'
require 'open-uri'

Category.destroy_all
Destination.destroy_all
Place.destroy_all
BannerPlace.destroy_all

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

doc_destinations = Nokogiri::HTML(URI.open("https://www.britannica.com/topic/list-of-cities-and-towns-in-Italy-2047404"))

doc_destinations.css("section").each do |destination|
  region = destination.css("h2").text
  destination.css("ul li a").each do |place|
    city = place.children.text

    Destination.create(name: city, region: region)
  end
end

array_of_destionations.each do |destination|
  Destination.create(name: destination)
end


doc_banner = Nokogiri::HTML(URI.open("https://unsplash.com/collections/K4_v8gc61jw/italianbanner"))
doc_banner.css('figure a img').each do |img|
  search_array = img.values[3].split
  next if search_array[26].nil?

  url = search_array[26]
  BannerPlace.create(
    photo_url: url
  )

  break if BannerPlace.count > 56
end

doc_photo = Nokogiri::HTML(URI.open("https://unsplash.com/collections/9FKBTb41_jU/italian"))
doc_photo.css('figure a img').each do |img|
  search_array = img.values[3].split
  next if search_array[14].nil?

  url = search_array[14]
  PhotoPlace.create(
    photo_url: url
  )

  break if PhotoPlace.count > 56
end

doc_places = Nokogiri::HTML(URI.open('https://www.forketers.com/120-italian-restaurant-names-will-amaze-even-italians/'))

doc_places.css('ol li').each do |places|
  Place.create(
    name:  places.children[0].text.capitalize,
    stars: rand(1..5),
    destination_id: rand(1..Destination.count)
  )
end


