class Answer < ActiveRecord::Base
  validates :a_content, :question_id, :user_id, presence: true

  belongs_to :question

  belongs_to :user

  has_many :comments

  has_many :votes
end
