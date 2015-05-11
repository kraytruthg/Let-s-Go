class CommentsController < ApplicationController
  before_action :require_login, only: [:create]
  before_action :set_trip_and_post, only: [:create]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user

    if @comment.save
      @comment.create_activity :create, owner: current_user, recipient: @trip
      flash[:notice] = 'Your comment was added'
      redirect_to trip_post_path(@trip, @post)
    else
      render 'posts/show'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_trip_and_post
    @trip = Trip.find_by(slug: params[:trip_id])
    @post = Post.find_by(slug: params[:post_id])
  end
end
