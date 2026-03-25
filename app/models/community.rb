class Community < ApplicationRecord
  belongs_to :user

  has_many :community_users
  has_many :users, through: :community_users

  validates :name, presence: true
  validates :body, presence: true
end
