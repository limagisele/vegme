class MenuItemsController < ApplicationController
  def index
    @restaurants = Role.find_by_name('restaurant').users
  end

  def show
    @restaurant_menu = User.find(params[:id]).menu_items
  end
end
