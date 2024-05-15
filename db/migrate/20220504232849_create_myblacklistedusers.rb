class CreateMyblacklistedusers < ActiveRecord::Migration[6.0]
  def change
    create_table :myblacklistedusers do |t|
      t.integer :blacklisted_id
      t.integer :user_id
	t.timestamps
    end
    create_table :myfavoriteusers do |t|
      t.integer :favorite_id
      t.integer :user_id
	t.timestamps
    end
  end
end
