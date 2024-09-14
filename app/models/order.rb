class Order < ApplicationRecord
  belongs_to :user
  has_many :cart, dependent: :destroy
end
