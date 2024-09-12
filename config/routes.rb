Rails.application.routes.draw do
  # devise_for :users
  # devise_for :admins

  # root to: ""
  draw :admin
  draw :user

  root to: 'admin/products#index'
end
