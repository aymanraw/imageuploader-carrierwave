class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :img
      t.belongs_to :product, index: true

      t.timestamps
    end
  end
end
