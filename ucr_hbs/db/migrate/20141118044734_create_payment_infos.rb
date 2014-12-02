class CreatePaymentInfos < ActiveRecord::Migration
  def change
    create_table :payment_infos do |t|
      t.string :first_name
      t.string :last_name
      t.string :address1
      t.string :address2
      t.string :state
      t.string :country
      t.string :ccn
      t.string :cvs
      t.date :expiration_date
      t.references :user, index: true

      t.timestamps
    end
  end
end
