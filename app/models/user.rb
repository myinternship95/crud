class User < ActiveRecord::Base
  validates_presence_of :firstname, :lastname, :email, :about_me
  validates :email, :presence => true, 
                       :uniqueness => true
  validates :password, :presence => true
  has_secure_password
  has_many :books
end
