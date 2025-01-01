class StoresController < ApplicationController
  before_action :set_store, only: [:show, :dashboard, :submit_rating]
  before_action :require_store_owner

  def show
    @store = Store.find(params[:id])
    @user_rating = @store.ratings.find_by(user_id: current_user.id)
  end

  def dashboard
    if @store.user != current_user
        redirect_to root_path, alert: 'You are not authorized to view this page.'
        return
    end
    @ratings = @store.ratings.includes(:user)
    @average_rating = @store.ratings.average(:rating).to_f
  end

  def submit_rating
    rating = @store.ratings.find_or_initialize_by(user: current_user)

    if rating.update(rating_params)
      redirect_to user_dashboard_path, notice: 'Your rating has been submitted!'
    else
      redirect_to @store, alert: 'There was an error submitting your rating.'
    end
  end

  private

  def set_store
    @store = Store.find(params[:id])
  end

  def rating_params
    params.require(:rating).permit(:rating)
  end
end
