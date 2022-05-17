class MenuItemsController < ApplicationController
  # DEBUG ONLY - REMOVE FOR PRODUCTION!
  # skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [:index]
  before_action :check_auth
  before_action :set_menu_item, only: [:show, :update, :edit, :destroy, :add_to_order]
  before_action :set_order, only: [:show_menu, :add_to_order]

  def index
    if user_signed_in? && current_user.has_role?(:restaurant)
      @restaurants = Role.find_by_name('restaurant').users.where(id: current_user.id)
    else
      @restaurants = Role.find_by_name('restaurant').users
    end
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

  def add_to_order
    if @order.menu_items.include?(@menu_item)
      item = @menu_item.order_menu_items.find_by_order_id(@order.id)
      quantity = item.quantity.to_i + params[:quantity].to_i
      item.update(quantity: quantity)
    else
      @order.order_menu_items.create!(order_item_params)
    end
    redirect_to order_menu_items_path
  end

  def edit
  end

  def update
    @menu_item.update!(menu_item_params)
    redirect_to @menu_item
  end

  def destroy
    @restaurant_id = @menu_item.user_id
    @menu_item.photo.purge
    @menu_item.destroy
    redirect_to menu_path(@restaurant_id)
  end

  private

  def check_auth
    authorize MenuItem
  end

  def menu_item_params
    return params.require(:menu_item).permit(:name, :description, :price, :available, :user_id, :photo)
  end

  def set_menu_item
    @menu_item = MenuItem.find(params[:id])
  end

  def set_order
    @order = Order.find(session[:order_id])
  rescue ActiveRecord::RecordNotFound
    @order = Order.create(user_id: current_user.id)
    session[:order_id] = @order.id
  end
  
  def order_item_params
    return params.permit(:order_id, :menu_item_id, :quantity)
  end
end
