class Trip < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  mount_uploader :cover, PictureUploader
  validates :name, presence: true
  validates :start_date, presence: true
  validates :start_date, presence: true
  validates :cover, presence: true
  validate :cover_size

  private
    def cover_size
      if cover.size > 5.megabytes
        errors.add(:cover, "should be less than 5MB")
      end
    end

end