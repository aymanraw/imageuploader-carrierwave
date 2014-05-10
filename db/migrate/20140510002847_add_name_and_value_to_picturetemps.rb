class AddNameAndValueToPicturetemps < ActiveRecord::Migration
  def change
    add_column :picture_temps, :pic_name, :string
    add_column :picture_temps, :pic_value, :string
  end
end
