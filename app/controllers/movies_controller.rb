class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def insert
    film = Movie.new

    film.title = params.fetch("movie_title")
    film.year = params.fetch("movie_year")
    film.duration = params.fetch("movie_duration")
    film.description = params.fetch("movie_description")
    film.image = params.fetch("movie_img")
    film.director_id = params.fetch("movie_director")

    film.save

    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def update
    @id = params.fetch("id")
    film = Movie.where({ :id => @id }).first

    if params.fetch("movie_title") != ""
      film.title = params.fetch("movie_title")
    end
    if params.fetch("movie_year") != ""
      film.year = params.fetch("movie_year")
    end
    if params.fetch("movie_duration") != ""
      film.duration = params.fetch("movie_duration")
    end
    if params.fetch("movie_description") != ""
      film.description = params.fetch("movie_description")
    end
    if params.fetch("movie_img") != ""
      film.image = params.fetch("movie_img")
    end
    if params.fetch("movie_director") != ""
      film.director_id = params.fetch("movie_director")
    end

    film.save

    redirect_to("/movies/" + @id.to_s)
  end

  def delete
    @id = params.fetch("id")
    film = Movie.where({ :id => @id }).first

    film.destroy()

    redirect_to("/movies")
  end
end
