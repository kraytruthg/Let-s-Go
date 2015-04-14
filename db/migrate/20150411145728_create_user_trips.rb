class CreateUserTrips < ActiveRecord::Migration
  def change
    create_table :user_trips do |t|
      t.integer :user_id, :trip_id
    end
  end
end
