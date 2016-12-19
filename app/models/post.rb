class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, through: :likes
  has_many :likes
  
  validates :content, presence: true, length: { maximum: 5000 }
  validates :user_id, presence: true

 	def feed
    Post.where('user_id = ?', id).order(created_at: :desc)
  end
end
