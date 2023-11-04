class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def insert
    star = Actor.new

    star.name = params.fetch("actor_name")
    star.dob = params.fetch("actor_dob")
    star.bio = params.fetch("actor_bio")
    star.image = params.fetch("actor_img")

    star.save

    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def update
    @id = params.fetch("id")
    star = Actor.where({ :id => @id }).first

    if params.fetch("actor_name") != ""
      star.name = params.fetch("actor_name")
    end
    if params.fetch("actor_dob") != ""
      star.dob = params.fetch("actor_dob")
    end
    if params.fetch("actor_bio") != ""
      star.bio = params.fetch("actor_bio")
    end
    if params.fetch("actor_img") != ""
      star.image = params.fetch("actor_img")
    end

    star.save

    redirect_to("/actors/" + @id.to_s)
  end

  def delete
    @id = params.fetch("id")
    star = Actor.where({ :id => @id }).first

    star.destroy()

    redirect_to("/actors")
  end

end
