class PostsController < ApplicationController
  before_action :set_trip
  before_action :require_login_as_trip_member
  before_action :set_post, only:[:edit, :update, :show]
  before_action :set_tag_autocomplete, only:[:new, :edit]
  before_action :require_creator, only:[:edit, :update]

  def new
    @post = @trip.posts.build
    @post.start_date = @trip.start_date
    @post.end_date   = @trip.end_date
  end

  def create
    @post = @trip.posts.build(post_params)
    @post.creator = current_user

    if @post.save
      @post.tag_ids = []
      @trip.tag(@post, with: params[:post][:tag_list], on: :tags)
      flash[:notice] = 'Your post was added'
      redirect_to @trip
    else
      render 'new'
    end
  end

  def star
    post = Post.find_by(slug: params[:post_id])
    if post.status == 'active'
      post.status = nil
    else
      post.status = 'active'
    end
    post.save

    redirect_to :back
  end

  def like
    post = Post.find_by(slug: params[:post_id])
    if post.users.include?(current_user)
      post.users.delete(current_user)
    else
      post.users << current_user
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'shared/like', :locals => { object: post} }
    end
  end

  def edit; end

  def update
    @post.update(post_params)
    if @post.save
      @post.tag_list = []
      @trip.tag(@post, with: params[:post][:tag_list], on: :tags)
      flash[:notice] = "Post was updated"
      redirect_to trip_post_path(@trip, @post)
    else
      render 'edit'
    end
  end

  def show
    @comment = Comment.new
  end

  private
    def set_trip
      @trip = Trip.find_by(slug: params[:trip_id])
    end

    def require_login_as_trip_member
      if !@trip.users.include?(current_user) || !logged_in?
        flash[:error] = 'You are not trip member'
        redirect_to root_path
      end
    end

    def set_post
      @post = Post.find_by(slug: params[:id])
    end

    def set_tag_autocomplete
      @autocomplete_items = @trip.owned_tags
    end

    def post_params
      params.require(:post).permit(:title, :description, :start_date, :end_date, :picture)
    end

    def require_creator
      if @post.creator != current_user
        flash[:error] = "You can't do that!"
        redirect_to @trip
      end
    end
end