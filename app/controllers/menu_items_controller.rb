class MenuItemsController < ApplicationController
  # DEBUG ONLY - REMOVE FOR PRODUCTION!
  # skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [:index]
  before_action :check_auth
  before_action :set_menu_item, only: [:show, :update, :edit, :destroy, :add_to_order]
  before_action :set_order, only: [:show_menu, :add_to_order]

  def index
    if user_signed_in? && current_user.has_role?(:restaurant)
      # Querying user only with required fields for the view (full_name and id)
      # Eager loading used to query Users, MenuItems, and Attachment all at once

      # When the user is a restaurant, only its restaurant will be displayed
      @restaurants = User.select(:full_name, :id).includes(menu_items: [:photo_attachment]).where(id: current_user.id)
    else
      # When user is a customer, all restaurants will be displayed
      @restaurants = Role.find_by_name('restaurant').users.select(:full_name, :id).includes(menu_items: [:photo_attachment])
    end
  end

  def show_menu
    # Finding the requested restaurant
    # Querying only the attributes required in the view file
    # Using eager loading to query User, MenuItems and Attachment at once to minimise db calls in the view loop
    @restaurant = User.select(:full_name, :id).includes(menu_items: [:photo_attachment]).find(params[:id])
    # Defining an array with all menu_items associated with the chosen restaurant
    @menu = @restaurant.menu_items
  end

  def show
  end

  def new
    @menu_item = MenuItem.new
  end

  def create
    @menu_item = MenuItem.create(menu_item_params)
    if @menu_item.valid?
      redirect_to @menu_item
    else
      flash.now[:alert] = @menu_item.errors.full_messages.join('<br>')
      render 'new'
    end
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
  rescue
    flash.now[:alert] = @menu_item.errors.full_messages.join('<br>')
    render 'edit'
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

  # Strong params for creating and updating a menu_item
  def menu_item_params
    return params.require(:menu_item).permit(:name, :description, :price, :available, :user_id, :photo)
  end

  # Creating a variable with a specific menu_item to be displayed, updated and deleted
  # Selecting only the attributes needed in views and actions
  def set_menu_item
    @menu_item = MenuItem.select(:id, :user_id, :name, :description, :price, :available).find(params[:id])
  end

  # Setting a session-based order for the current user when accessing the 'Menu Items' page
  def set_order
    @order = Order.find(session[:order_id])
  rescue ActiveRecord::RecordNotFound
    @order = Order.create(user_id: current_user.id)
    session[:order_id] = @order.id
  end

  # Strong params for updating an order_menu_item
  def order_item_params
    return params.permit(:order_id, :menu_item_id, :quantity)
  end
end
