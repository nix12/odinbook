class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, through: :likes
  has_many :likes
  
  validates :content, presence: true, length: { maximum: 5000 }, 
                      allow_blank:true
  validates :user_id, presence: true

  has_attached_file :image, styles: { medium: "250x250>", thumb: "150x150#" }, 
                            default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

 	def feed
    Post.where('user_id = ?', id).order(created_at: :desc)
  end
end
