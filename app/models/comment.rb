class Comment < ActiveRecord::Base
  validates :c_content, presence: true

  belongs_to :answer

  belongs_to :question

  belongs_to :user


end
