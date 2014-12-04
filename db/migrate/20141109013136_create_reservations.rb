class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :hotel_id
      t.date :arrival_date
      t.date :departure_date
      t.decimal :rate
      t.references :user, index: true

      t.timestamps
    end
  end
end
