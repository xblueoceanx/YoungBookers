Rails.application.routes.draw do
  devise_for :reviewers

  get 'homes/about'

  resources :reviews, only: [:new, :create, :index, :show, :edit, :destroy, :update]

  resources :reviewers, only: [:show, :edit, :update, :index]

  root "homes#top"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
