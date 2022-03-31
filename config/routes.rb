Rails.application.routes.draw do
  resources :users

  root "users#index"
  get 'profile/:id', to: "users#profile", :as => :profile
  post 'profile/:id', to: "users#post_profile"
  get "/password/:id", to: "users#password", :as => :password
  post "/password/:id", to: "users#post_password"

end
