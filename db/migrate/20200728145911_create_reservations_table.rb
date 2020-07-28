class CreateReservationsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.integer :hotel_id 
      t.integer :user_id 
    end 
  end
end
