Rails.application.routes.draw do
  devise_for :users,controllers: {
    registrations: 'users/registrations'
  }
  # devise_for :users, controllers: {
  #       sessions: 'users/sessions'
  #     }

  resources :stories

  root 'pages#index'
  
end
