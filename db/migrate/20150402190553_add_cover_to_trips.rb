class AddCoverToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :cover, :string
  end
end
