class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  
  validates :content, presence: true, length: { maximum: 5000 }
  validates :user_id, presence: true
end
