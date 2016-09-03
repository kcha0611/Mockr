class Question < ActiveRecord::Base
  validates :q_title, :user_id, presence: true

  belongs_to :user

  has_many :answers

  acts_as_votable

  has_many :comments

end
