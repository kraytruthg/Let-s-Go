class Like < ActiveRecord::Base
  include PublicActivity::Common
  belongs_to :liker ,foreign_key: 'user_id', class_name: 'User'
  belongs_to :like ,foreign_key: 'post_id', class_name: 'Post'
end