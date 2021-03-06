Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 resources :articles do
   member do
     post :join
     post :quit
   end
   resources :comments
 end

 namespace :account do
   resources :articles
   resources :comments
 end

 root 'articles#index'
end
