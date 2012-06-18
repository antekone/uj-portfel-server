class User < ActiveRecord::Base
  has_one  :profile, dependent: :destroy
  has_many :sent_invitations, foreign_key: :user_id
  has_many :received_invitations, foreign_key: :recipient_id
  has_many :accounts
  has_many :public_accounts, through: :sent_invitations,     source: :account
  has_many :shared_accounts, through: :received_invitations, source: :account
  has_many :transactions, dependent: :delete_all
  has_many :tags, dependent: :delete_all
  has_many :sessions, dependent: :delete_all
  
  has_secure_password
  attr_accessible :email, :phone, :password, :password_confirmation
  
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: true
  
  after_create :generate_profile
  after_create :generate_main_account
  
  def generate_profile
    self.create_profile
  end
  
  def generate_main_account
    self.accounts.create(public: true, currency: "PLN")
  end
  
  def email_with_phone
    [self.email, self.phone].compact.join(" - ")
  end
  
  def as_json(options={})
    super(options.merge!(except: [:password_digest]))
  end
end
