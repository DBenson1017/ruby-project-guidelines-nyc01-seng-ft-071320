class CreateHotelsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :hotels do |t|
        t.string :name
        t.string :price
        t.string :beds
        t.string :guest_amount
        t.string :neighborhood
    end
  end
end