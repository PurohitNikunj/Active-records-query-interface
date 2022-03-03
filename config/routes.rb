Rails.application.routes.draw do
  resources :orders
  resources :products
  devise_for :users, :controllers => {:registrations => "registrations"}
  root "homes#index"
  get 'profile', to: "homes#profile", :as => :profile

end
