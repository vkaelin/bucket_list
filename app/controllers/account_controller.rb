class AccountController < ApplicationController
  before_action :ensure_authenticated

  def ideas
    user = User.find(session[:user_id])
    @ideas = user.ideas
  end

  def ensure_authenticated
    redirect_to(login_path) unless(logged_in?)
  end
end
