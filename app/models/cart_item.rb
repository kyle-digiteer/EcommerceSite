class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product_variant
  has_one :product, through: :product_variant

  validates :quantity, numericality: { greater_than: 0 }
  validate :check_stock, on: :create

  def check_stock
    return unless product_variant.stock < quantity

    errors.add(:quantity, 'is more than available stock for this product')
  end
end
