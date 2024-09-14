class AddOrderToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :order, null: true, foreign_key: true # TODO: temporary true but change to false
  end
end
