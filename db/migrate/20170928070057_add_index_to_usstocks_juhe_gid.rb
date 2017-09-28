class AddIndexToUsstocksJuheGid < ActiveRecord::Migration[5.0]
  def change
    add_index :usstocks, :juhe_gid
  end
end
