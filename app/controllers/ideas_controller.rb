class IdeasController < ApplicationController
  def index
    @search_term = params[:q]
    @ideas = Idea.search(@search_term)
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_resource_params)
    if(@idea.save)
      redirect_to(ideas_path)
    else
      render 'new'
    end
  end

  def edit
    id = params[:id]
    @idea = Idea.find(id)
  end

  def update
    @idea = Idea.find(params[:id])
    if(@idea.update(idea_resource_params))
      redirect_to(account_ideas_path)
    else
      render 'edit'
    end
  end

  private

  def idea_resource_params
    params.require(:idea).permit(:title, :description, :photo_url, :done_count)
  end
end
