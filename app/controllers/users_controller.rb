class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def profile
  end

  def search
    @users = User.all(:conditions => ["username = ? OR email = ?", params[:q], params[:q]])
  end

end
