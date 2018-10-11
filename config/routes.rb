Rails.application.routes.draw do
  resources :styles
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  root 'breweries#index'
  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :memberships
  get 'signup', to: 'users#new'
  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  post 'places', to:'places#search'
  resources :places, only: [:index, :show]
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :users do
    post 'toggle_active', on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
