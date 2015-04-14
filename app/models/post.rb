class Post < ActiveRecord::Base
  include Sluggable
  acts_as_taggable_on :tags
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post
  has_many :comments
  has_many :user_posts
  has_many :users, through: :user_posts

  mount_uploader :picture, PictureUploader
  sluggable_column :title
end