class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.string :url
      t.timestamps
    end
    create_table :mypublicphotos do |t|
      t.integer :user_id
      t.integer :photo_id
    end
    create_table :myprivatephotos do |t|
      t.integer :user_id
      t.integer :photo_id
    end
  end
end
