class Invitation < ActiveRecord::Base
  STATES = {
    sent:     1,
    accepted: 2,
    rejected: 3 
  }.freeze
  
  belongs_to :user
  belongs_to :recipient, class_name: "User"
  belongs_to :account
  attr_accessible :user_id, :recipient_id, :account_id, :state, :recipient_email, :recipient_phone
  
  validates :user_id, presence: true
  validates :account_id, presence: true
  validates :recipient_email, presence: true
  validates :state, :inclusion => { :in => STATES.values }
  
  before_create :find_recipient
  
  def state_name
    STATES.detect { |k, v| v == self.state }.first
  end
  
  def find_recipient
    self.recipient ||= User.find_by_email(self.recipient_email.downcase)
  end
end
