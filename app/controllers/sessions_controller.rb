class SessionsController < ApplicationController
    before_action :redirect_if_logged_in, only: [:new, :create]
  
    def new
    end
  
    def create
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:notice] = 'Logged in successfully.'
        redirect_to dashboard_path(user)
      else
        flash.now[:alert] = "Invalid email or password"
        render :new
      end
    end
  
    def destroy
      session[:user_id] = nil
      redirect_to login_path, notice: "Logged out successfully"
    end
  
    private
  
    def dashboard_path(user)
      case user.role
      when 'store_owner'
        store = user.store
        store ? dashboard_store_path(store) : root_path
      when 'admin'
        admin_dashboard_path
      else
        user_dashboard_path(user)
      end
    end
  
    def redirect_if_logged_in
      if session[:user_id]
        user = User.find_by(id: session[:user_id])
        if user
          redirect_to dashboard_path(user), notice: "You are already logged in."
        end
      end
    end
  end
  