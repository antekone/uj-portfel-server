# encoding: UTF-8
class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions, dependent: :delete_all
  
  attr_accessible :name, :public, :currency, :balance
  
  validates :user_id, presence: true
  validates :currency, presence: true
  
  before_create :complete_name
  
  def balance
    read_attribute(:balance_in_cents).to_f/100
  end
  
  def balance=(balance)
    write_attribute(:balance_in_cents, balance.gsub(",", ".").to_f*100)
  end
  
  def complete_name
    write_attribute(:name, "Domyślne") unless self.name?
  end
  
  def as_json(options={})
    super(options.merge(methods: [:balance]))
  end
end
