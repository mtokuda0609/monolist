class User < ApplicationRecord
  has_many :ownerships, foreign_key: 'user_id', dependent: :destroy
  has_many :items, through: :ownerships
  
  has_many :wants
  has_many :want_items, through: :wants, class_name: 'Item', source: :item

  validates :name, presence: true,
      length: { maximum: 50 }
  
  before_save { self.email.downcase! }
  validates :email, presence: true,
      length: { maximum: 255 },
      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
      uniqueness: { case_sensitive: false }
  
  has_secure_password


  def want(item)
    self.wants.find_or_create_by(item_id: item.id)
  end
  
  def unwant(item)
    want = self.wants.find_by(item_id: item.id)
    want.destroy if want
  end
  
  def want?(item)
    self.want_items.include?(item)
  end

end