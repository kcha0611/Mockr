class User < ActiveRecord::Base
  validates :first_name, :last_name, presence: { message: "cannot be blank"}
  validates :email, presence: true, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}

  has_secure_password

  has_many :questions

  has_many :answers

  has_many :votes

  has_many :answercomments

  has_many :comments

  acts_as_voter
end
