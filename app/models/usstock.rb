class Usstock < ApplicationRecord

  def to_param
    self.juhe_gid
  end

  def usstock?
    self.stock_type == "美股"
  end

  def hkstock?
    self.stock_type == "港股"
  end

end
