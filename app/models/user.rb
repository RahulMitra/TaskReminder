class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :number, :username, :password, :password_confirmation
  has_many :activities
  include Enumerable
  require 'digest/sha1'
  
  @password
  @password_confirmation
    
	# User validations:
	# first_name, and last_name must not be blank and must only contain letters
	# username must not be blank, must not be already taken (case insensitive), and must be at least 3 characters
	# number must not be blank, must not be already taken, and must be 10 digits
	# password must not be blank, and must match the second password field
	validates :first_name, :presence => true, :format => { :with => /\A[a-zA-Z]+\z/, :message => "must only contain letters" }
	validates :last_name, :presence => true, :format => { :with => /\A[a-zA-Z]+\z/, :message => "must ony contain letters" }
	validates :username, :presence => true, :uniqueness => { :case_sensitive => false }, :length => {:minimum => 4}
	validates :number, :presence => true, :uniqueness => true, :numericality => {:only_integer => true, :message => "digits only"}, :length => {:is => 10}
  validates :password, :presence => true, :confirmation => true  

    def full_name
      "#{first_name} #{last_name}"
    end

  	def password_confirmation
  	  return @password_confirmation
  	end

  	def password_confirmation=(password)
  	    @password_confirmation = Digest::SHA1.hexdigest(password + self.salt)
    end

  	def password()
      return self.password_digest
    end

    def password=(password)
    	  self.salt = rand(1000).to_s
        self.password_digest = Digest::SHA1.hexdigest(password + self.salt)
    end

  	def password_valid?(password)
  	  if (self.password_digest == Digest::SHA1.hexdigest(password + self.salt))
  	    return true
  	  else
  	    return false
      end
    end
end
