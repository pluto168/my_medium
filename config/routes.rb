Rails.application.routes.draw do
  devise_for :users,controllers: {
    #registrations: 'users/registrations',
    #sessions: 'users/sessions'
  }


  namespace :api do
    # namespace :v2 do     #隨時可以改版號,路徑變成api/v2/users/:id/follow
      #/users/:id/follow  
      resources :users, only: [] do      #[]空陣列,不要7條路徑,只要id
        member do
          post :follow
        end
      end

      #/stories/:id/clap
      resources :stories, only: [] do    #[]空陣列,不要7條路徑,只要id
        member do          #clap 需要:id
          post :clap
        end 
      end
    # end
  end
  

  #只留CRUD
  resources :stories do
    # member do          #clap 需要:id 搬到上面api
    #   post :clap
    # end 
    resources :comments, only: [:create] #只留CRUD
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
