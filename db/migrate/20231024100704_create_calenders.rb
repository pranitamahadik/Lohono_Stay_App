class CreateCalenders < ActiveRecord::Migration[7.0]
  def change
    create_table :calenders do |t|
      t.references :villa, null: false, foreign_key: true
      t.integer :rate_per_night
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
    add_index :calenders, :start_date
    add_index :calenders, :end_date
  end
end
