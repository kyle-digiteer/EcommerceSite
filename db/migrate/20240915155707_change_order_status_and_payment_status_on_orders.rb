class ChangeOrderStatusAndPaymentStatusOnOrders < ActiveRecord::Migration[7.1]
  def change
    # Ensure columns are set to string type for enum values
    change_column :orders, :order_status, :string, default: 'pending'
    change_column :orders, :payment_status, :string, default: 'pending'
  end
end
