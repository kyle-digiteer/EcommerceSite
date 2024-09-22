class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :cart
  has_one :wallet
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :create_wallet_on_register
  # migration should have default value
  # callback method
  # has_one create_wallet

  private

  def create_wallet_on_register
    create_wallet
  end
end
