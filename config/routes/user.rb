devise_for :users,
           path: '/',
           controllers: {
             sessions: 'user/sessions',
             passwords: 'user/passwords',
             registrations: 'user/registrations'
             #  omniauth_callbacks: 'site/omniauth_callbacks'
           },
           path_names: {
             sign_in: '/login',
             sign_up: '/register',
             password: '/forgot',
             sign_out: '/logout',
             confirmation: '/confirm',
             unlock: '/unblock',
             password_expired: '/password-expired'
           }

namespace :user, path: '/' do
  resources :home

  resources :products

  resources :carts, only: %i[show create update destroy]
  resources :carts_item, only: %i[create update destroy]

  resources :orders, only: [] do
    collection do
      post :checkout
      get :confirmation
    end
  end
end
