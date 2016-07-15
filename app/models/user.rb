class User < ApplicationRecord
  
  #Properties
  before_save { self.email = self.email.downcase }

  #Validations concerning name
  validates(:name, 
            presence: true, 
            length: { maximum: 64 })

  #Validations concerning email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates(:email,
            presence: true, 
            length: { maximum: 255 }, 
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false })

  #Concerning password
  has_secure_password
 
  validates(:password, 
            presence: true, 
            length: { minimum: 6 })


  # Returns the hash digest of given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine::cost
    BCrypt::Password.create(string, cost: cost)
  end


end

