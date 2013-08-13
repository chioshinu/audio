class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def profile
  end

  def search
    @users = User.all(:conditions => ["username like ? OR email like ?", "%#{params[:q]}%", "%#{params[:q]}%"])
    @current_user = current_user
  end

end
