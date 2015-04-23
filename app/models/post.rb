class Post < ActiveRecord::Base
  include Sluggable
  acts_as_taggable_on :tags
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :trip
  has_many :comments
  has_many :likes
  has_many :likers, through: :likes

  mount_uploader :picture, PictureUploader
  sluggable_column :title

  NEW_POST_TITLE = 'New Post'

  def self.new_post
    post = Post.new(title: NEW_POST_TITLE, start_date: Date.current, end_date: Date.current)
  end
end