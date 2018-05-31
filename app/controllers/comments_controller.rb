class CommentsController < ApplicationController
  before_action :ensure_authenticated

  def create
    idea = Idea.find(params[:idea_id])
    @comment = Comment.new(comment_params)
    @comment.idea = idea
    @comment.user = current_user
    @comment.save!
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
