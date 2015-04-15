class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'You are registered'
      session[:user_id] = @user.slug
      demo_trip = Trip.find_by(slug: 'demo-trip') # Set default demo trip to new registered user
      @user.trips.push(demo_trip)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def autocomplete
    @users = User.order(:username).where("username LIKE ?", "%#{params[:term]}%")
    respond_to do |format|
      format.html
      format.json {
        render json: @users.map(&:username)
      }
    end
  end

  private

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def require_same_user
    if current_user != @user
      flash[:error] = "You are not allow to do that"
      redirect_to root_path
    end
  end
end
