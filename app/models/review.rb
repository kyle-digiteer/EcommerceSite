class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :rating, numericality: { only_integer: true, less_than_or_equal_to: 5, greater_than_or_equal_to: 0 },
                     presence: true
  validates :title, length: { minimum: 3, maximum: 100 }
  validates :description, length: { minimum: 5, maximum: 255 }

  def belongs_to_user?(current_user_id)
    user_id == current_user_id
  end
end
