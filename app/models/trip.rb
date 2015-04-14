class Trip < ActiveRecord::Base
  include Sluggable
  acts_as_tagger

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :posts
  has_many :user_trips
  has_many :users, through: :user_trips

  mount_uploader :cover, PictureUploader
  validates :name, presence: true
  validates :start_date, presence: true
  validates :start_date, presence: true
  validates :cover, presence: true
  validate :cover_size

  sluggable_column :name

  def user_list
    self.users.map(&:username)
  end

  private
    def cover_size
      if cover.size > 5.megabytes
        errors.add(:cover, "should be less than 5MB")
      end
    end

end