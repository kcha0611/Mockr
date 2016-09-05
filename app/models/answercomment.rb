class Answercomment < ActiveRecord::Base
  validates :answercomment_content, presence: true

  belongs_to :answer

  belongs_to :user

  acts_as_votable
end
