class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def update_total_price
    self.total_price = cart_items.joins(:product_variant).sum('cart_items.quantity * product_variants.price')
    save
  end
end
