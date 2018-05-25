class CommentsController < ApplicationController
  def create
    @user = User.find(session[:user_id])
    @idea = Idea.find(params[:idea_id])
    @comment = Comment.new(comment_params)
    @comment.user = @user
    @comment.idea = @idea
    @comment.save
    puts "Errors: #{@comment.errors.full_messages}"
    redirect_to(idea_path(@idea))
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
