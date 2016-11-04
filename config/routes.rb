Rails.application.routes.draw do
  root to: 'landing#index'

  resources :boards
  resources :games
end
