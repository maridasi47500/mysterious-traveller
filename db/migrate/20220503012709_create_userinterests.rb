class CreateUserinterests < ActiveRecord::Migration[6.0]
  def change
    create_table :userinterests do |t|
      t.integer :interest_id
      t.integer :user_id
    end
  end
end
