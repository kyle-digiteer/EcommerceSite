class ChangeColumnDefaultOfWalletBalance < ActiveRecord::Migration[7.1]
  def change
    change_column_default :wallets, :balance, from: nil, to: 0
  end
end
