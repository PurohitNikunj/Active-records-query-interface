Rails.application.routes.draw do
  resources :events
  resources :users
  get 'login', to: "users#get_login"
  post 'login', to: "users#post_login"
  get 'home', to: "homes#home"
  get 'logout/:id', to: "users#logout"
  get 'join_event/:id', to: "homes#join_event"
  get 'leave/:id', to: "users#leave"
  get 'filter/:id', to: "events#filter"
  get 'comment/:id', to: "homes#comment", :as => :comment
  post 'comment/:id', to: "homes#post_comment"
  get 'delete_comment/:id', to: "homes#delete_comment", :as => :delete_comment
  get 'like_comment/:id', to: "homes#like_comment", :as => :like_comment
  get 'unlike_comment/:id', to: "homes#unlike_comment", :as => :unlike_comment

  # resources :orders
  # resources :customers
  # resources :products
  # get 'root', to: "roots#root"
  # get 'default_scope', to: "products#default_scope"
  # get 'boots/index'
  # post 'search', to: "orders#search"
  # get 'filter', to: "orders#filter"
  # post 'filter', to: "orders#post_filter"
  # resources :employees
  # get 'email_existance', to: "employees#new_email_existance"
  # post 'email_existance', to: "employees#create_email_existance"
  # get 'queryset', to: "employees#queryset"
  # get 'inc_order/:id', to: "employees#inc_order"
  # get 'dec_order/:id', to: "employees#dec_order"
  # get 'overriding', to: "employees#overriding"
end
