Rails.application.routes.draw do
  root 'menu_items#index'
  get 'menu_items', to: 'menu_items#index'
  get 'menu_items/menu/:id', to: 'menu_items#show_menu', as: 'menu'
  get 'menu_items/new', to: 'menu_items#new'
  get 'menu_items/:id', to: 'menu_items#show', as: 'menu_item'
  post 'menu_items', to: 'menu_items#create'
  post 'menu_items/:id/add', to: 'menu_items#add_to_order', as: 'add_to_order'
  get 'menu_items/:id/edit', to: 'menu_items#edit', as: 'edit_menu_item'
  patch 'menu_items/:id', to: 'menu_items#update'
  delete 'menu_items/:id', to: 'menu_items#destroy'

  get 'order_menu_items', to: 'order_menu_items#index'
  post 'order_menu_items', to: 'order_menu_items#create'
  patch 'order_menu_items/:id', to: 'order_menu_items#update'
  delete 'order_menu_items/delete_all', to: 'order_menu_items#destroy_all_items', as: 'destroy_all_items'
  delete 'order_menu_items/:id', to: 'order_menu_items#destroy'

  get 'payments/success', to: 'payments#success'
  post 'payments/webhook', to: 'payments#webhook'

  devise_scope :user do
    # Redirects signing out users back to sign-in
    get "users", to: "devise/sessions#new"
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
end
