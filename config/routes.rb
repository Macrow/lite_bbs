LiteBbs::Engine.routes.draw do

  root :to => 'sections#index'
  
  resources :sections, only: [:index, :show]
  resources :forums, only: [:show] do
    resources :topics, only: [:create]
  end
  resources :topics, only: [:show, :edit, :update, :destroy] do
    put 'toggle_stick', on: :member
    put 'toggle_can_reply', on: :member
    resources :replies, only: [:create]
  end
  resources :replies, only: [:edit, :update, :destroy]
  
  match 'search' => 'search#index', as: :search
  match 'advanced_search' => 'search#advance', as: :advanced_search
  
  namespace :admin do
    root :to => 'home#index'
    resources :sections, except: [:show] do
      put 'order', on: :collection
      get 'confirm_destroy', on: :member
    end
    resources :forums, except: [:show] do
      put 'order', on: :collection
      get 'confirm_destroy', on: :member
    end
    resources :topics, except: [:show]
  end
end
