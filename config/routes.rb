Rails.application.routes.draw do
  devise_for :users,controllers: {
    #registrations: 'users/registrations',
    #sessions: 'users/sessions'
  }
  # /stories/:id/clap
  resources :stories do
    member do          #clap 需要:id
      post :clap
    end 
    resources :comments, only: [:create]
  end

 
  #/@user/article-123
  get '@:username/:story_id', to: 'pages#show',as: 'story_page'
  #/@user/
  get '@:username', to: 'pages#user',as: 'user_page'

  get '/demo', to: 'pages#demo'
  
  root 'pages#index'
end


  # namespace :username do
  #   resources :pages, :story_id do
  #     get :user
  #   end
  # end
