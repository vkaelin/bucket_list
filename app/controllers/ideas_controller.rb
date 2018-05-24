class IdeasController < ApplicationController
  def index
    @search_term = params[:q]
    @ideas = Idea.search(@search_term)
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def new
  end

  def create
    idea = Idea.new(params)
    idea.save!
    redirect_to(ideas_index_path)
  end

  def edit
    id = params[:id]
    @idea = Idea.find(id)
  end

  def update
    idea = Idea.find(params[:id])
    idea.update(params)
    redirect_to(account_ideas_path)
  end
end
