Rails.application.routes.draw do
  scope "/:locale", locale: /en|pt\-BR/  do
    resources :rooms
    resources :users
    
    resource :confirmation, :only => [:show]
  end

  root to: "home#index"
  
  # resources :rooms
  # resources :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
