Rails.application.routes.draw do

  resources :products do
    resources :orders
  end
  resources :customers, module: 'business', path: 'business/customers', only: [:index, :new, :create, :edit, :update]

  root "products#index"
  post 'search', to: "business/customers#search"
  get 'delete_customer', to: "business/customers#get_destroy", :as => :delete_customer
  post 'delete_customer', to: "business/customers#post_destroy"
  get 'preview', to: "business/customers#index", :as => :preview
end
