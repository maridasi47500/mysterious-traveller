class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.string :name
      t.timestamps
    end
    create_table :userrelationships do |t|
      t.integer :user_id
      t.integer :relationship_id
      t.timestamps
    end
  end
end
