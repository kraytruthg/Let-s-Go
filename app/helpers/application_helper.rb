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
end
