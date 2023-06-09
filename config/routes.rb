Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :conversations, only: [:create]
  get 'conversations/new/:persona_id', to: 'conversations#new', as: 'new_conversation'
end