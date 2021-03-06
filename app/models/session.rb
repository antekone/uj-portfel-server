class Session < ActiveRecord::Base
  belongs_to :user
  attr_accessible []
  
  before_create :generate_token
  
  scope :active, where("updated_at > ?", Time.now - 2.hours)
  
  private
    def generate_token
      self.token = SecureRandom.hex
    end
end