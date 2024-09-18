class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  has_many :order_items, dependent: :destroy

  enum order_status: { pending: 'Pending', processing: 'Processing', completed: 'Completed', cancelled: 'Cancelled' }
  enum payment_status: { pending_payment: 'Pending', paid: 'Paid', failed: 'Failed', refunded: 'Refunded' }

  def total_price
    order_items.sum { |item| item.price * item.quantity }
  end
end
