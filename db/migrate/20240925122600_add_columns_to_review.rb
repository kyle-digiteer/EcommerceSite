class AddColumnsToReview < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :rating, :integer
    add_column :reviews, :title, :string
    add_column :reviews, :description, :text
  end
end
