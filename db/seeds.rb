require 'nokogiri'
require 'open-uri'
require 'uri'

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
puts "==============================="

puts "Creating Destinations..."
## Adds destinations to the database

doc_destinations = Nokogiri::HTML(URI.open("https://www.britannica.com/topic/list-of-cities-and-towns-in-Italy-2047404"))

doc_destinations.css("section").each do |destination|
  region = destination.css("h2").text
  destination.css("ul li a").each do |place|
    city = place.children.text

    add_banner_image = ""

    banner_image = Nokogiri::HTML(URI.open("https://unsplash.com/collections/3x2_s_xw0f0/destinationbanner"))
    banner_image.css("figure a img").each do |banner|
      image_banner = banner.values[3].split
      next if image_banner[26].nil?

      add_banner_image = image_banner[26]
    end

    add_photo_image = ""

    photo_image =  Nokogiri::HTML(URI.open("https://unsplash.com/collections/yBTX506UD_8/destinationcard"))
    photo_image.css("figure a img").each do |photo|
      image_photo = photo.values[3].split
      next if image_photo[14].nil?

      add_photo_image = image_photo[14]
    end

    Destination.create(
      name: city,
      region: region
    )
    banner_path = File.basename(URI.parse(add_banner_image).path)
    file = URI.open(add_banner_image.to_s)

    Destination.last.banner.attach(io: file, filename: banner_path, content_type: "image/jpeg")

    photo_path = File.basename(URI.parse(add_photo_image).path)
    file = URI.open(add_photo_image.to_s)
    Destination.last.photo.attach(io: file, filename: photo_path, content_type: "image/jpeg")

    puts "Destination #{city} created with success!"
    sleep 5
    break if Destination.count > 59
  end
end

puts "Destinations created with success!"

# doc_banner = Nokogiri::HTML(URI.open("https://unsplash.com/collections/K4_v8gc61jw/italianbanner"))
# doc_banner.css('figure a img').each do |img|
#   search_array = img.values[3].split
#   next if search_array[26].nil?

#   url = search_array[26]
#   BannerPlace.create(
#     photo_url: url
#   )

#   break if BannerPlace.count > 56
# end

# doc_photo = Nokogiri::HTML(URI.open("https://unsplash.com/collections/9FKBTb41_jU/italian"))
# doc_photo.css('figure a img').each do |img|
#   search_array = img.values[3].split
#   next if search_array[14].nil?

#   url = search_array[14]
#   PhotoPlace.create(
#     photo_url: url
#   )

#   break if PhotoPlace.count > 56
# end

# doc_places = Nokogiri::HTML(URI.open('https://www.forketers.com/120-italian-restaurant-names-will-amaze-even-italians/'))

# doc_places.css('ol li').each do |places|
#   Place.create(
#     name:  places.children[0].text.capitalize,
#     stars: rand(1..5),
#     destination_id: rand(1..Destination.count)
#   )
# end


