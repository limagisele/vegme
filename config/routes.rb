Rails.application.routes.draw do
  root 'menu_items#index'
  get 'menu_items', to: 'menu_items#index'
  get 'menu_items/menu/:id', to: 'menu_items#show_menu', as: 'menu'
  get 'menu_items/new', to: 'menu_items#new'
  get 'menu_items/:id', to: 'menu_items#show', as: 'menu_item'
  post 'menu_items', to: 'menu_items#create'
  get 'menu_items/:id/edit', to: 'menu_items#edit'
  patch 'menu_items/:id', to: 'menu_items#update'
  delete 'menu_items/:id', to: 'menu_items#destroy'

  devise_scope :user do
    # Redirects signing out users back to sign-in
    get "users", to: "devise/sessions#new"
  end

  devise_for :users
end
