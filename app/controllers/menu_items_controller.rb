class MenuItemsController < ApplicationController
  # DEBUG ONLY - REMOVE FOR PRODUCTION!
  # skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [:index]
  before_action :check_auth
  before_action :set_menu_item, only: [:show, :update, :edit, :destroy]

  def index
    @restaurants = Role.find_by_name('restaurant').users
  end

  def show_menu
    @restaurant = User.find(params[:id])
    @menu = User.find(params[:id]).menu_items.order(:name)
  end

  def show
  end

  def new
    @menu_item = MenuItem.new
  end

  def create
    menu_item = MenuItem.create!(menu_item_params)
    redirect_to menu_item
  end

  def edit
    
  end

  def update
    @menu_item.update!(menu_item_params)
    redirect_to @menu_item
  end

  def destroy
    @restaurant_id = @menu_item.user_id
    @menu_item.destroy
    redirect_to menu_path(@restaurant_id)
  end

  private

  def check_auth
    authorize MenuItem
  end

  def menu_item_params
    return params.require(:menu_item).permit(:name, :description, :price, :available, :user_id)
  end

  def set_menu_item
    @menu_item = MenuItem.find(params[:id])
  end
end
