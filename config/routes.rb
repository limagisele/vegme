Rails.application.routes.draw do
  root 'menu_items#index'
  get 'menu_items', to: 'menu_items#index'
  get 'menu_items/:id', to: 'menu_items#show', as: 'restaurant'
  get 'menu_items/item/:id', to: 'menu_items#show_item', as: 'item'

  devise_scope :user do
    # Redirects signing out users back to sign-in
    get "users", to: "devise/sessions#new"
  end

  devise_for :users
end
