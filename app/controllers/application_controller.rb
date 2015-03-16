class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def authenticate_user!
    if signed_in?
      @current_user = User.find session[:user_id]
    else
      redirect_to sign_in_path
    end
  end

  def signed_in?
    session[:user_id].to_i > 0
  end
end
