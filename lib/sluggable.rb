module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug
    class_attribute :slug_column
  end

  def to_param
    self.slug
  end

  def generate_slug
    the_slug = to_slug(self.send(self.class.slug_column.to_sym))
    objs = self.class.where("slug like '#{the_slug}%'")
    if objs.any?
      if objs.include?(self)
        self.slug
      else
        self.slug = the_slug + '-' + find_slug_index(objs.select{ |obj| obj.slug.split('-').last.to_i != 0 })
      end
    else
      self.slug = the_slug
    end
  end

  def find_slug_index(objs)
    if objs.empty?
      2.to_s
    else
      objs.sort_by!{ |e| e.slug }
      index = objs.last.slug.split('-').last.to_i
      index += 1
      index.to_s
    end
  end

  def to_slug(name)
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9\u4e00-\u9fa5]/, '-'
    str.gsub! /-+/,"-"
    str.downcase
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end
