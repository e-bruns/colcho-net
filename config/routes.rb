Rails.application.routes.draw do
  scope "/:locale", locale: /en|pt\-BR/  do
    resources :rooms do
      resources :reviews, only: [:create, :update], module: :rooms
      # resources :picture, only: [:create, :destroy]
    end

    resources :users
    
    resource :confirmation, only: [:show]

    resource :user_sessions, only: [:create, :new, :destroy]
    get 'login', to: 'user_sessions#new', as: 'login'
    get 'logout', to: 'user_sessions#destroy', as: 'logout'
  end

  root to: "home#index"
  
  # resources :rooms
  # resources :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
