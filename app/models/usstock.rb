class Usstock < ApplicationRecord

  def to_param
    self.juhe_gid
  end

end
