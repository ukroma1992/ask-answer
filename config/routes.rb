Rails.application.routes.draw do
  
  root 'users#index'

  resources :users
  resource :questions
end
