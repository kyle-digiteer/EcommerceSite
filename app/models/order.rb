class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  has_many :order_items, dependent: :destroy

  enum order_status: { pending: 'Pending', processing: 'Processing', completed: 'Completed', cancelled: 'Cancelled' }
  enum payment_status: { pending_payment: 'Pending', paid: 'Paid', failed: 'Failed', refunded: 'Refunded' }

  def total_price
    order_items.sum { |item| item.price * item.quantity }
  end

  def order_completed?
    order_status == 'completed' && payment_status == 'paid'
  end

  def not_review?(product_id, current_user_id)
    all_product_review = Product.find(product_id).reviews.all

    all_product_review.where(user_id: current_user_id).empty?
    # last line return
    # empty? => return true if empty, [], {}, ''
    # present? => returns true if present
    # nil? => returns true if nill
    # blank? => returns true if NOT BLANK, it will return false if you have [], {}, ''
  end
end
