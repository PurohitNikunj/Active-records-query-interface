Rails.application.routes.draw do
  
  resources :orders
  resources :customers
  resources :products
  get 'root', to: "roots#root"
  get 'default_scope', to: "products#default_scope"
  get 'boots/index'
  post 'search', to: "orders#search"
  get 'filter', to: "orders#filter"
  post 'filter', to: "orders#post_filter"
  resources :employees
  get 'email_existance', to: "employees#new_email_existance"
  post 'email_existance', to: "employees#create_email_existance"
  get 'queryset', to: "employees#queryset"
  get 'inc_order/:id', to: "employees#inc_order"
  get 'dec_order/:id', to: "employees#dec_order"
  get 'overriding', to: "employees#overriding"
end
