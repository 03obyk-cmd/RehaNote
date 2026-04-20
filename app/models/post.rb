class Post < ApplicationRecord
  belongs_to :user
  belongs_to :community

  has_many :comments, dependent: :destroy

  enum :start_position, { lying: 0, sitting: 1, standing: 2 }

  validates :title, presence: true
  validates :start_position, presence: true
  validates :exercise_description, presence: true
  validates :record_example, presence: true

end
