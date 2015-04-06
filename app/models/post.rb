class Post < ActiveRecord::Base
  include Sluggable
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post

  mount_uploader :picture, PictureUploader
  sluggable_column :title
end