Rails.application.routes.draw do
  get 'users/new'

  #get 'users/new'

  root 'static_pages#home'
  root 'chat_rooms#index'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  mount ActionCable.server => '/cable'
  
  resources :users
  resources :dashboard
  resources :chat_rooms, only: [:new, :create, :show, :index]

end
