class FixUsstockDate < ActiveRecord::Migration[5.0]
  def change
    rename_column :usstocks, :chtime, :time
  end
end
