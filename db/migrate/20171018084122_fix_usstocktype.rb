class FixUsstocktype < ActiveRecord::Migration[5.0]
  def change
    Usstock.find_each do |u|
      if u.stock_type.nil?
        u.update(:stock_type => "美股")
      end
    end
  end
end
