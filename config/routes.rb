Rails.application.routes.draw do
  # root to: ""
  draw :admin
  draw :user

  root to: 'user/home#index'
end
