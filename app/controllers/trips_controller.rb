class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update]
  before_action :require_login_as_trip_member, only: [:show]
  before_action :require_creator, only: [:edit, :update]

  def new
    @trip = Trip.new
    @trip.start_date = @trip.end_date = Date.current
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.creator = current_user
    if @trip.save
      update_member_list
      flash[:notice] = 'Your trip was created'
      redirect_to @trip
    else
      render 'new'
    end
  end

  def edit; end

  def update
    @trip.update(trip_params)
    if @trip.save
      update_member_list
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
      if !@trip.users.include?(current_user) || !logged_in?
        flash[:error] = 'You are not trip member'
        redirect_to root_path
      end
    end

    def update_member_list
      member_list = params[:trip][:member_list].split(',')
      @trip.users = []
      member_list.each{ |username|
        if user = User.where('lower(username) = ?', username.downcase).first
          @trip.users.push user
        end
      }
    end

    def require_creator
      if @trip.creator != current_user
        flash[:error] = "You can't do that!"
        redirect_to @trip
      end
    end
end