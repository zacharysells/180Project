class AddCityToPaymentInfos < ActiveRecord::Migration
  def change
    add_column :payment_infos, :city, :string
  end
end
