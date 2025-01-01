class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      flash[:alert] = "You must be logged in to access this page."
      redirect_to login_path
    end
  end

  def require_admin
    unless current_user&.admin?
      flash[:alert] = "You must be an admin to access this page."
      redirect_to root_path
    end
  end

  def require_store_owner
    unless current_user&.store_owner?
      flash[:alert] = "You must be a store owner to access this page."
      redirect_to root_path
    end
  end
end
