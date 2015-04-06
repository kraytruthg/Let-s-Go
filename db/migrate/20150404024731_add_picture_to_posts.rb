class AddPictureToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :picture, :string
    add_column :posts, :start_date, :datetime
    add_column :posts, :end_date, :datetime
  end
end
