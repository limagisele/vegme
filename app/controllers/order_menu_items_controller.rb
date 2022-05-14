class OrderMenuItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order
  before_action :set_order_item, only: [:update, :destroy]
  before_action :set_order_items, only: [:index, :destroy_all_items]

  def index
    @order_items = @order.order_menu_items
    if user_signed_in? && current_user.has_role?(:customer) && @order_items.size != 0
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        customer_email: current_user.email,
        line_items: [{
          name: 'VegMe Order',
          description: "Meal from #{@order.menu_items.first.user.full_name}",
          images: ['https://res.cloudinary.com/limagisele/image/upload/v1652509895/VegMe_ljjeph.png'],
          amount: (@order.order_total_price * 100).to_i,
          currency: 'aud',
          quantity: 1,
        }],
        payment_intent_data: {
          metadata: {
            order_id: @order.id,
            user_id: current_user.id
          }
        },
        success_url: "#{root_url}payments/success?orderId=#{@order.id}",
        cancel_url: "#{root_url}order_menu_items"
      )
      @session_id = session.id
    end
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
