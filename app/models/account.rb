class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions, dependent: :delete_all
  
  attr_accessible :name, :public, :currency, :balance
  
  validates :user_id, presence: true
  validates :currency, presence: true
  
  def balance
    read_attribute(:balance_in_cents).to_f/100
  end
  
  def balance=(balance)
    write_attribute(:balance_in_cents, balance.gsub(",", ".").to_f*100)
  end
  
  def as_json(options={})
    super(options.merge(methods: [:balance]))
  end
end
