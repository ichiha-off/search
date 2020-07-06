Rails.application.routes.draw do

  get 'favorites/create'
  get 'favorites/destroy'
  root 'homes#top' 
  get 'home/about' => 'homes#about'
  get 'search' => 'searches#search'

  devise_for :users

  resources :users,only: [:show,:index,:edit,:update] do
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end
  
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]


end
