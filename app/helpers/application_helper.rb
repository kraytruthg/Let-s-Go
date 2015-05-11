module ApplicationHelper
  def fix_url(url)
    url.start_with?('http://') ? url : 'http://' + url
  end

  def format_datetime(dt)
    dt.strftime("%F %T")
  end

  def format_date(dt)
    dt.strftime("%F")
  end

  def show_period(obj)
    if obj.start_date == obj.end_date
      format_date(obj.start_date)
    else
      "#{format_date(obj.start_date)} ~ #{format_date(obj.end_date)}"
    end
  end

  def show_or_create_post(trip, post)
    if post.title == Post::NEW_POST_TITLE
      new_trip_post_path(trip)
    else
      trip_post_path(trip,post)
    end
  end

  def show_trip_member_list(trip)
    trip.users.map(&:username).join(', ')
  end
end
