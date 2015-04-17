# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

movie_titles = ["good will hunting", "spartacus", "jerry maguire"]
movie_titles.each do |movie_title|

  giffy_base = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag="
    response = HTTParty.get('http://www.omdbapi.com/?t=' + movie_title)
    movie = Movie.create(title: response["Title"], year: response["Year"].to_i, poster_url: response["Poster"], plot: response["Plot"])

    actors = response["Actors"].split(", ")
    actors[0..2].each do |actor|
        actor.gsub!(/\P{ASCII}/, '')
        puts actor
        giffy_response = HTTParty.get(giffy_base + actor.downcase.gsub(" ", "+"))["data"]["image_url"]
        movie.actors.create({name: actor, photo_url: giffy_response})
    end
end

