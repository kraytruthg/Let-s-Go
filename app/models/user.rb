class User < ActiveRecord::Base
  include Sluggable

  has_many :trips
  has_many :user_trips
  has_many :trips, through: :user_trips

  has_secure_password validations:false
  validates :username, presence:true, uniqueness: { case_sensitive: false }
  validates :password, presence:true, allow_nil: true, length: { minimum: 6 }
  sluggable_column :username
end