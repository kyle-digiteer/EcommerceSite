class ProductVariant < ApplicationRecord
  belongs_to :product

  # validates :price, :color, :size, :stock, presence: true

  #   validates :price, numericality: { greater_than: 0 }
  #
  #   validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
