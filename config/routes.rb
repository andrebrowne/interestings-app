Rails.application.routes.draw do
  root 'otds#index'
  resources :otds, :only => :index
end
