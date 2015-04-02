class CreatePost < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url, :title, :description
      t.integer :user_id, :trip_id
      t.timestamps null: false
    end
  end
end
