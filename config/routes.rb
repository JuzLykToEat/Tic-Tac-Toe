Rails.application.routes.draw do
  root to: 'landing#index'

  resources :boards
  resources :games

  post :place_x, to: 'cells#place_x'
  post :place_o, to: 'cells#place_o'
end
