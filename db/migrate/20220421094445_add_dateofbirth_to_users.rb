class AddDateofbirthToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :dateofbirth, :date
    add_column :users, :phonenumber, :string
    add_column :users, :latitude, :string
    add_column :users, :longitude, :string
    add_column :users, :name, :string
    add_column :users, :fake_country, :string
    add_column :users, :country, :string
    add_column :users, :opt_in, :boolean
  end
end
