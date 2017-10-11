class FixPriearnToFloat < ActiveRecord::Migration[5.0]
  def change
    remove_column :likes, :priearn
    add_column :likes, :priearn, :float
  end
end
