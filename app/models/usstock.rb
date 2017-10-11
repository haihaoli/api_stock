class Usstock < ApplicationRecord
  has_many :likes, :dependent => :destroy
  has_many :liked_users, :through => :likes, :source => :user

  def to_param
    self.juhe_gid
  end

  def usstock?
    self.stock_type == "美股"
  end

  def hkstock?
    self.stock_type == "港股"
  end

  def cnstock?
    self.stock_type == "沪市" || self.stock_type == "深市"
  end

  def find_like(user)
    self.likes.where( :user_id => user.id ).first
  end

end
