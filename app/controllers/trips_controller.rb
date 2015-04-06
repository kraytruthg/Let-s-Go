class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update]

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
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
  end

  def index
    @trips = Trip.all
  end

  private
    def trip_params
      params.require(:trip).permit(:name, :start_date, :end_date, :cover)
    end

    def set_trip
      @trip = Trip.find_by(slug: params[:id])
    end
end