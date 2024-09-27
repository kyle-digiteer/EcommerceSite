class Product < ApplicationRecord
  has_many :product_variants, dependent: :destroy
  has_many :reviews , dependent: :destroy
  accepts_nested_attributes_for :product_variants, allow_destroy: true

  validates :name, length: { minimum: 3, maximum: 100 }
  validates :description, length: { minimum: 10, maximum: 250}
end
