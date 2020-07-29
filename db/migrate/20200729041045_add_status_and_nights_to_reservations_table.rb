class AddStatusAndNightsToReservationsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :active, :boolean
    add_column :reservations, :num_of_nights, :integer
  end
end
