class CreateOrthodoxHoroscopes < ActiveRecord::Migration[6.0]
  def change
    create_table :orthodox_horoscopes do |t|
      t.date :begin
      t.date :end
      t.string :name
      t.text :description
      t.text :celebrities
	t.timestamps
    end
    create_table :chinese_horoscope_dates do |t|
      t.integer :chinese_horoscope_id
      t.date :begin
      t.date :end
	end
    create_table :chinese_horoscopes do |t|
      t.string :name
      t.text :description
      t.text :pro
      t.text :con
      t.string :lucky_numbers
	t.timestamps
    end
  end
end
