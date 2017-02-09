class Book < ActiveRecord::Base
  validates_presence_of :title, :authors, :publisher, :year
  belongs_to :user
end
