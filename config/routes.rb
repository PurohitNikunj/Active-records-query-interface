Rails.application.routes.draw do
  get 'boots/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :employees
  get 'email_existance', to: "employees#new_email_existance"
  post 'email_existance', to: "employees#create_email_existance"
  get 'queryset', to: "employees#queryset"
  get 'inc_order/:id', to: "employees#inc_order"
  get 'dec_order/:id', to: "employees#dec_order"
  get 'overriding', to: "employees#overriding"
end
