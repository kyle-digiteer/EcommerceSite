class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product_variant
  has_one :product, through: :product_variant

  validates :quantity, numericality: { greater_than: 0 }
end
