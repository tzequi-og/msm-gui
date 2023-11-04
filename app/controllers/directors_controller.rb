class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def insert
    boss = Director.new

    boss.name = params.fetch("director_name")
    boss.dob = params.fetch("director_dob")
    boss.bio = params.fetch("director_bio")
    boss.image = params.fetch("director_img")

    boss.save

    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def update
    @id = params.fetch("id")
    boss = Director.where({ :id => @id }).first

    if params.fetch("director_name") != ""
      boss.name = params.fetch("director_name")
    end
    if params.fetch("director_dob") != ""
      boss.dob = params.fetch("director_dob")
    end
    if params.fetch("director_bio") != ""
      boss.bio = params.fetch("director_bio")
    end
    if params.fetch("director_img") != ""
      boss.image = params.fetch("director_img")
    end

    boss.save

    redirect_to("/directors/" + @id.to_s)
  end

  def delete
    @id = params.fetch("id")
    star = Director.where({ :id => @id }).first

    star.destroy()

    redirect_to("/directors")
  end
end
