class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  has_many :taggings, dependent: :delete_all
  has_many :tags, through: :taggings
  
  has_attached_file :attachment
  attr_accessible :user_id, :account_id, :value, :description, :date, :attachment, :tag_names
  
  validates :user_id, presence: true
  validates :account_id, presence: true
  
  after_save    :update_account_balance
  after_destroy :update_account_balance
  
  def tag_names
    self.tags.pluck(:name).join(", ")
  end
  
  def tag_names=(tag_names)
    self.tags = tag_names.split(",").map { |n| self.user.tags.find_or_create_by_name(n.downcase.strip) }
  end
  
  def value
    read_attribute(:value_in_cents).to_f/100
  end
  
  def value=(value)
    write_attribute(:value_in_cents, value.gsub(",", ".").to_f*100)
  end
  
  def update_account_balance
    self.account.update_attribute(:balance_in_cents, self.account.transactions.sum(:value_in_cents))
  end
  
  def as_json(options={})
    super(options.merge(methods: [:value]))
  end
end
