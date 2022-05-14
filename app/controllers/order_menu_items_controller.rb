class OrderMenuItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order
  before_action :set_order_item, only: [:update, :destroy]
  before_action :set_order_items, only: [:index, :destroy_all_items]

  def index
    @order_items = @order.order_menu_items
  end

  def create
    @order_item = @order.order_menu_items.create!(order_item_params)
    redirect_to order_menu_items_path
  end

  def update
    @order_item.update!(order_item_params)
    redirect_to order_menu_items_path
  end

  def destroy
    @order_item.destroy
    redirect_to order_menu_items_path
  end

  def destroy_all_items
    @order_items.destroy_all
    redirect_to order_menu_items_path
  end

  private

  def set_order_items
    @order_items = @order.order_menu_items
  end
  
  def set_order_item
    @order_item = @order.order_menu_items.find(params[:id])
  end

  def order_item_params
    return params.require(:order_menu_item).permit(:order_id, :menu_item_id, :quantity)
  end

  def order_params
    return params.require(:order).permit(:user_id)
  end

  def set_order
    @order = Order.find(session[:order_id])
  rescue ActiveRecord::RecordNotFound
    @order = Order.create(user_id: current_user.id)
    session[:order_id] = @order.id
  end
end
