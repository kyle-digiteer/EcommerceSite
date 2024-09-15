class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  has_many :order_items, dependent: :destroy

  enum order_status: { pending: 'pending', completed: 'completed', cancelled: 'cancelled' }
  enum payment_status: { pending_payment: 'pending', paid: 'paid', failed: 'failed' }

  def total_price
    order_items.sum { |item| item.price * item.quantity }
  end
end
