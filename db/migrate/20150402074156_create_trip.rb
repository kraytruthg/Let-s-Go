class CreateTrip < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.date :start_date, :end_date
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
