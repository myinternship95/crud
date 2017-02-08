class User < ActiveRecord::Base
  validates_presence_of :username, :email
  validates :username, :presence => true, 
                       :uniqueness => true
  validates :password, :presence => true
  has_secure_password
  has_many :projects
  has_many :parts, through: :projects
end
