# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'uri'
require 'net/http'

url = URI("https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MDY5ZjhlMmVkYjI1NmU5ZTM5YzBiYjQyY2ZjNWI2MyIsIm5iZiI6MTY3NzQ0ODYwNC45MTYsInN1YiI6IjYzZmJkNTljOTZlMzBiMDA4N2Y4Njg5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._7djtxCvFS_U87SvOjKXI3cC-Xnhz2IXeIVbCbk_iIU'

response = http.request(request)
results = JSON.parse(response.read_body)["results"]


puts "Cleaning database"
Movie.destroy_all
15.times do |number|
  overview = results[number]["overview"]
  title = results[number]["original_title"]
  poster_url= results[number]["poster_path"]
  puts "Generating a new movie entry"
  movie = Movie.new(
  title: title,
  overview: overview,
  poster_url: poster_url)
  movie.save!
  puts "#{movie.title} was added"
end
