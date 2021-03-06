=begin
class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates(:name, presence: true, length: { maximum: 50})
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates(:email, presence: true, length: { maximum: 255},
  									format: {with: VALID_EMAIL_REGEX },
  									uniqueness: { case_sensitive: false })
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
=end

class User < ActiveRecord::Base



  	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  	USER_REGEX = /\A[a-z0-9_-]{3,20}\z/
  	PASSWORD_REGEX = /\A[a-z0-9]{6,20}\z/
  	validates :name, :presence => true, :uniqueness => true, :format => USER_REGEX, :length => { :in => 3..20 }
  	validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  	validates :password, :presence => true
  	has_secure_password
  	validates :password, :confirmation => true #password_confirmation attr
  	validates_length_of :password, :in => 6..20, :on => :create
    before_save { self.email = email.downcase }

	has_many :chat_rooms, dependent: :destroy
	has_many :messages, dependent: :destroy
=begin
	def encrypt_password
	  if password.present?
	    self.salt = BCrypt::Engine.generate_salt
	    self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
	  end
	end

	def clear_password
	  self.password = nil
	end
=end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
