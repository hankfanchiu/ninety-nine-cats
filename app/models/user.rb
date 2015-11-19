class User < ActiveRecord::Base
  attr_reader :password

  after_initialize :set_session_token

  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :cats, dependent: :destroy

  has_many :requests,
    class_name: "CatRentalRequest",
    foreign_key: :user_id

  def self.find_by_credentials(username, password)
    user = self.find_by(username: username)

    if user
      user.is_password?(password) ? user : nil
    else
      nil
    end
  end

  def is_password?(password)
    digest = BCrypt::Password.new(self.password_digest)
    digest.is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def generate_session_token
    self.session_token = SecureRandom::urlsafe_base64
  end

  def set_session_token
    self.session_token || generate_session_token
  end

  def reset_session_token!
    generate_session_token
    self.save!
  end
end
