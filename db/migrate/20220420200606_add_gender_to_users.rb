class AddGenderToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :gender, :string
    add_column :users, :femalesearched, :boolean
    add_column :users, :malesearched, :boolean
  end
end
