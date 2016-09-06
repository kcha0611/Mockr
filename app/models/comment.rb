class Comment < ActiveRecord::Base
  validates :c_content, presence: true

  acts_as_votable 

  belongs_to :answer

  belongs_to :question

  belongs_to :user


end
