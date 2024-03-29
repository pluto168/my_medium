Rails.application.routes.draw do
  devise_for :users,controllers: {
    #registrations: 'users/registrations',
    #sessions: 'users/sessions'
  }


  namespace :api do
    # namespace :v2 do     #隨時可以改版號,路徑變成api/v2/users/:id/follow
      #app/frontend/packs/editor.js
      post :upload_image, to: 'utils#upload_image'
      #api/users/:id/follow  
      resources :users, only: [] do      #[]空陣列,不要7條路徑,只要id
        member do
          post :follow
        end
      end

      #api/stories/:id/clap
      resources :stories, only: [] do    #[]空陣列,不要7條路徑,只要id
        member do          #clap 需要:id
          post :clap
          #/api/stories/:id/bookmark
          post :bookmark
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

  #會員付費
  resources :users, only: [] do
    collection do
      get :pricing   #/users/pricing
      get :payment   #/users/payman
      post :pay      #/users/pay  負責跟braintree的server溝通,不需要畫面,寫在form_with
    end
  end

  #/@user/article-123 文章標題
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
