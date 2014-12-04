class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :hotel_id
      t.integer :stars
      t.text :body
      t.date :review_date
      t.references :user, index: true

      t.timestamps
    end
  end
end
