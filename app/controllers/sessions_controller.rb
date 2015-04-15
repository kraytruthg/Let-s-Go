class SessionsController < ApplicationController

  def new; end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      flash[:notice] = 'Welcome back! ' + user.username
      session[:user_id] = user.slug
      redirect_to root_path
    else
      flash.now[:error] = 'There is something wrong with your name or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out"
    redirect_to root_path
  end
end