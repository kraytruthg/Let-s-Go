class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :user_list]
  before_action :require_login_as_trip_member, except: [:index]

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.start_date = @trip.end_date = Date.current
    @trip.creator = current_user
    if @trip.save
      flash[:notice] = 'Your trip was created'
      redirect_to @trip
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    @trip.update(trip_params)
    if @trip.save
      flash[:notice] = "Trip was updated"
      redirect_to @trip
    else
      render 'edit'
    end
  end

  def show
    @posts = @trip.posts
    if params[:date]
      select_date = params[:date].to_datetime
      @posts = @posts.where('start_date <= ?', select_date)
      @posts = @posts.where('end_date   >= ?', select_date)
    end

    if params[:tag]
      tag = ActsAsTaggableOn::Tag.find_by(name: params[:tag])
      @posts = @posts.select{ |p| p.tags.include?(tag) }
    end
  end

  def index
    if logged_in?
      @trips = current_user.trips
    end
  end

  private
    def trip_params
      params.require(:trip).permit(:name, :start_date, :end_date, :cover)
    end

    def set_trip
      @trip = Trip.find_by(slug: params[:id])
    end

    def require_login_as_trip_member
      require_login
    end
end