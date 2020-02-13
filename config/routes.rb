Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  namespace :api do
    post :upload_image, to: 'utils#upload_image'
    
    resources :users, only: [] do
      member do
        post :follow
      end
    end

    resources :stories, only: [] do
      member do
        post :clap
        post :bookmark
      end
      resources :comments, only: [:create]
    end
  end
  
  resources :stories do
    resources :comments, only: [:create]
  end

  # /@howhow/文章標題-123
  get '@:username/:story_id', to: 'pages#show', as: 'story_page'

  # /@howhow/
  get '@:username', to: 'pages#user', as: 'user_page'

  get "/demo", to: 'pages#demo'
  root 'pages#index'
end
