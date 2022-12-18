Rails.application.routes.draw do
  devise_for :users,controllers: {
    #registrations: 'users/registrations',
    #sessions: 'users/sessions'
  }

  resources :stories

  #/@user/文章標題-123
  get '@:username/:story_id', to: 'pages#show', as: 'story_page'

   #/@user
   get '@:username', to: 'pages#user', as: 'user_page'

  root 'pages#index'
  
end
