class AddWeightToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :weight, :string
    add_column :users, :height, :string
    add_column :users, :subdivision, :string
    add_column :users, :description, :text
  end
end
