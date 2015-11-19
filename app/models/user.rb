class User < ActiveRecord::Base
  attr_reader :password

  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :cats, dependent: :destroy

  has_many :requests,
    class_name: "CatRentalRequest",
    foreign_key: :user_id
end
