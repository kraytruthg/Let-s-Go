class ActivitiesController < ApplicationController
  def index
    @trip = Trip.find_by(slug: params[:trip_id])
    @activities = PublicActivity::Activity.order("created_at desc").where(recipient: @trip)
  end
end