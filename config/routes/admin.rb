devise_for :admins,
           path: 'admin',
           controllers: {
             sessions: 'admin/sessions',
             passwords: 'admin/passwords'
           },
           path_names: {
             sign_in: '/login',
             password: '/forgot',
             sign_out: '/logout',
             confirmation: '/confirm',
             unlock: '/unblock',
             password_expired: '/password-expired'
           }
namespace :admin, path: 'admin' do
  resources :products
end
