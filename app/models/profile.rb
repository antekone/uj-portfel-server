class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :surname, :age, :description
  
  validates :user_id, :presence => true
end
