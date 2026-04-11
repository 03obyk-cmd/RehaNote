class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_one_attached :profile_image

  has_many :community_users, dependent: :destroy
  has_many :communities, through: :community_users
  has_many :posts

  validates :name, presence: true
  validates :email_address, presence: true

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/user.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'user.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
