Rails.application.routes.draw do
  get 'games/new', to: 'games#new'
  get 'games/score', to: 'games#score'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'up', to: 'rails/health#show'

  get 'new', to: 'games#new'
  post 'score', to: 'games#score'
end
