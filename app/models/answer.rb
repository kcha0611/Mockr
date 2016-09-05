class Answer < ActiveRecord::Base
  validates :a_content, :question_id, :user_id, presence: true

  belongs_to :question

  belongs_to :user

  acts_as_votable

  has_many :comments

  has_many :votes
end
