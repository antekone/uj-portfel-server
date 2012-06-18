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
  validates :state, :inclusion => { :in => STATES.values }
end
