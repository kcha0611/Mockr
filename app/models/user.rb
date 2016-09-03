class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: {minimum: 6, allow_nil: true}

  has_secure_password

  has_many :questions

  has_many :answers

  has_many :votes

  acts_as_voter
end
