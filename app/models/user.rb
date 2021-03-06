class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, omniauth_providers: [:facebook]

  validates :first_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :encrypted_password, presence: true, length: { minimum: 6 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_many :posts
  has_many :comments
  has_many :likes, through: :likes
  has_many :likes
  has_many :notifications, foreign_key: :recipient_id
  has_many :received_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friendships
  
  has_many :active_friends, -> { where(friendships: { accepted: true}) }, 
                                 through: :friendships, source: :friend
  has_many :received_friends, -> { where(friendships: { accepted: true}) }, 
                                   through: :received_friendships, source: :user
  has_many :pending_friends, -> { where(friendships: { accepted: false}) }, 
                                  through: :friendships, source: :friend
  has_many :requested_friendships, -> { where(friendships: { accepted: false}) }, 
                                        through: :received_friendships, source: :user

  def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.first_name = auth.info.first_name   # assuming the user model has a name
	    user.last_name = auth.info.last_name # assuming the user model has an image
	  end
	end

	def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def feed
    Post.where('user_id = ?', id).order(created_at: :desc)
  end

  def self.search(search)
    if search
      where('last_name LIKE ? OR first_name LIKE ?', "%#{search}%", "%#{search}%")
    else
      all
    end
  end

  def friends
    active_friends | received_friends
  end

  def pending
    pending_friends | requested_friendships
  end

  after_create :send_welcome_email
  def send_welcome_email
    UserMailer.send_welcome_email(self).deliver
  end
end
