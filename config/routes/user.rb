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
end
