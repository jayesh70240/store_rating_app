class UsersController < ApplicationController
    before_action :require_login, only: [:change_password, :update_password, :dashboard]
    
    def dashboard
        @stores = Store.all
        if params[:search].present?
            search_term = params[:search].downcase
            @stores = @stores.where('LOWER(name) LIKE :search OR LOWER(address) LIKE :search', search: "%#{search_term}%")
        end
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to login_path, notice: "Signup successful! Please log in."
        else
            flash.now[:alert] = @user.errors.full_messages.join(", ")
            render :new
        end
    end

    def change_password
    end

    def update_password
        if current_user&.authenticate(params[:current_password])
          if current_user.update(password: params[:new_password])
            redirect_to user_dashboard_path, notice: 'Password updated successfully.'
          else
            flash.now[:alert] = 'Failed to update password.'
            render :change_password
          end
        else
          flash.now[:alert] = 'Current password is incorrect.'
          render :change_password
        end
    end


    private

    def user_params
        params.require(:user).permit(:name, :email, :address, :password, :password_confirmation)
    end
end
