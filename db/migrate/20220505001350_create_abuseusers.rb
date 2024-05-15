class CreateAbuseusers < ActiveRecord::Migration[6.0]
  def change
    create_table :abuseusers do |t|
      t.integer :abuse_id
      t.integer :user_id
      t.timestamps
    end
  end
end
