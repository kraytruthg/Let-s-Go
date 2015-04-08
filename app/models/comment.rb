class Comment < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post
  validates :body, presence: true

  def self.human_attribute_name(attr, options = {})
    attr == :body ? 'Comment' : super
  end
end