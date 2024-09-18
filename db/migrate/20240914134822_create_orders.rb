class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true
      t.string :order_status
      t.string :payment_status
      t.float :total

      t.timestamps
    end
  end
end
