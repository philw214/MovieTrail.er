class MoviesController < ApplicationController

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
    @actors = @movie.actors.all

  end





  def new
    @movie = Movie.new
  end

  def create
    @movie_title = movie_params["title"]

    giffy_base = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag="
    response = HTTParty.get('http://www.omdbapi.com/?t=' + @movie_title)
    movie = Movie.create(title: response["Title"], year: response["Year"].to_i, poster_url: response["Poster"], plot: response["Plot"])

    actors = response["Actors"].split(", ")
    actors[0..2].each do |actor|
        actor.gsub!(/\P{ASCII}/, '')
        puts actor
        giffy_response = HTTParty.get(giffy_base + actor.downcase.gsub(" ", "+"))["data"]["image_url"]
        movie.actors.create({name: actor, photo_url: giffy_response})
    end
  redirect_to movies_path
  end

  private
    def movie_params
        params.require(:movie).permit(:title)
    end

end