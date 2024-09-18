class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product_variant
  has_one :product, through: :product_variant
end
