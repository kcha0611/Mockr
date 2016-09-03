class Comment < ActiveRecord::Base
  validates :answer_id, :c_content, presence: true

  belongs_to :answer

  belongs_to :question

  belongs_to :user


end
