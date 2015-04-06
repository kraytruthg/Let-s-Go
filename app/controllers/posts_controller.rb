class PostsController < ApplicationController
  before_action :set_trip
  before_action :set_post, only:[:edit, :update, :show]

  def new
    @post = @trip.posts.build
    @post.start_date = @post.end_date = Date.current
  end

  def create
    @post = @trip.posts.build(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = 'Your post was added'
      redirect_to @trip
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    @post.update(post_params)
    if @post.save
      flash[:notice] = "Post was updated"
      redirect_to trip_post_path(@trip, @post)
    else
      render 'edit'
    end
  end

  def show

  end

  private
    def set_trip
      @trip = Trip.find_by(slug: params[:trip_id])
    end

    def set_post
      @post = Post.find_by(slug: params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :description, :start_date, :end_date, :picture)
    end
end