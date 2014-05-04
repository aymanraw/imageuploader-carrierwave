class CreatePictureTemps < ActiveRecord::Migration
  def change
    create_table :picture_temps do |t|
      t.string :public_id

      t.timestamps
    end
  end
end
