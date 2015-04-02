module ApplicationHelper
  def fix_url(url)
    url.start_with?('http://') ? url : 'http://' + url
  end

  def format_datetime(dt)
    dt.strftime("%F %T %Z").in_time_zone("Taipei")
  end
end
