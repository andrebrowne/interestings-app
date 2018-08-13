Rails.application.routes.draw do
  root 'otds#index'
  resources :otds
  
end
