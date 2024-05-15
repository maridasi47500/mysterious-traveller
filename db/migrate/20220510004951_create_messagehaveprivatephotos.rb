class CreateMessagehaveprivatephotos < ActiveRecord::Migration[6.0]
  def change
    create_table :messagehaveprivatephotos do |t|
      t.integer :photo_id
      t.integer :message_id
    end
  end
end
