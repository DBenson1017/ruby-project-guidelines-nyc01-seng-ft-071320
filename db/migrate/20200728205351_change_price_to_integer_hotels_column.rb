class ChangePriceToIntegerHotelsColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :hotels, :price, :integer
  end
end
