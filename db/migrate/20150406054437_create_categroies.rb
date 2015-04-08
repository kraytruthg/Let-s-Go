class CreateCategroies < ActiveRecord::Migration
  def change
    create_table :categroies do |t|
      t.string :name
      t.string :slug
      t.integer :trip_id
    end
  end
end
