class UsersController < ApplicationController
  def new
     @user = User.new
  end

  def create
     @user = User.new(params.require(:user).permit(:firstname, :lastname, :email, :password))
  if @user.save
     @current_user = @user
     session[:user_id] = @user.id
     redirect_to dashboard_path
  else
     render :new
  end
  end
end
