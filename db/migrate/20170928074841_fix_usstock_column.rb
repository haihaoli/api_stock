class FixUsstockColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :usstocks, :lastestpri
    remove_column :usstocks, :openpri
    remove_column :usstocks, :formpri
    remove_column :usstocks, :limit
    remove_column :usstocks, :uppic
    remove_column :usstocks, :priearn
    remove_column :usstocks, :beta
    remove_column :usstocks, :chtime
    add_column :usstocks, :stock_type, :string
  end
end
