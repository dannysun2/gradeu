class SessionsController < ApplicationController
  def new
  end

  def create
     username = params[:username]
     password = params[:password]

     user = User.find_by username: username
     if user.try(:authenticate, password)
        session[:user_id] = user.id
        redirect_to dashboard_path
     else
        render :new
     end
  end

  def destroy
     session[:user_id] = nil
     redirect_to root_path
  end

end
