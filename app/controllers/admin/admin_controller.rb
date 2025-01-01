class Admin::AdminController < ApplicationController
    before_action :require_login
    before_action :require_admin

    def dashboard
      @total_users = User.count
      @total_stores = Store.count
      @total_ratings = Rating.count
    end
  
    def users
      @users = if params[:query].present?
             User.where("name ILIKE :query OR email ILIKE :query OR role ILIKE :query OR address ILIKE :query", query: "%#{params[:query]}%").page(params[:page]).per(10)
           else
             User.all.page(params[:page]).per(10)
           end
    end

  
    def new_user
      @user = User.new
    end
  
    def create_user
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path, notice: 'User added successfully!'
      else
        flash.now[:alert] = @user.errors.full_messages.join(", ")
        render :new_user
      end
    end
  
    def stores
      @stores = Store.joins(:user).where("stores.name ILIKE :query OR users.email ILIKE :query OR stores.address ILIKE :query", query: "%#{params[:query]}%").distinct.page(params[:page]).per(10)
    end
    
  
    def new_store
      @store = Store.new
    end
  
    def create_store
      @store = Store.new(store_params)
      if @store.save
        redirect_to admin_stores_path, notice: 'Store added successfully!'
      else
        render :new_store
      end
    end
  
    private
  
    def ensure_admin
      redirect_to root_path, alert: 'Access denied!' unless current_user&.role == 'admin'
    end
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :address, :role)
    end
  
    def store_params
      params.require(:store).permit(:name, :address, :user_id)
    end
  end
  