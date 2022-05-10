class MenuItemsController < ApplicationController
  def index
    @restaurants = Role.find_by_name('restaurant').users
  end

  def show
    @restaurant = User.find(params[:id]).menu_items
  end

  def show_item
    @item = MenuItem.find(params[:id])
  end
end
