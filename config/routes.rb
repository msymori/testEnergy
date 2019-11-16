Rails.application.routes.draw do
  root to: 'city#index'
  resources :city
end
