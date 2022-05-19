class OrderMenuItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order
  before_action :set_order_item, only: [:update, :destroy]
  before_action :set_order_items, only: [:index, :destroy_all_items]

  def index
    # Adding Stripe Checkout session only for customers with items added in the order
    if user_signed_in? && current_user.has_role?(:customer) && !@order_items.empty?
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        customer_email: current_user.email,
        line_items: [{
          name: 'VegMe Order',
          description: "Meal from #{@order.menu_items.first.user.full_name}",
          images: ['https://res.cloudinary.com/limagisele/image/upload/v1652509895/VegMe_ljjeph.png'],
          amount: (@order.order_total_price * 100).to_i,
          currency: 'aud',
          quantity: 1
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

  # Setting a session-based order for the current user when accessing the 'View Order' page
  def set_order
    @order = Order.find(session[:order_id])
  rescue ActiveRecord::RecordNotFound
    @order = Order.create(user_id: current_user.id)
    session[:order_id] = @order.id
  end

  def set_order_items
    # Creating a variable with all order_menu_items included in the current order
    # Querying only the required attributes for view and actions
    @order_items = @order.order_menu_items.select(:id, :menu_item_id, :quantity)
  end

  def set_order_item
    # Creating a variable with a specific order_menu_item from the current order
    # Querying only the required attributes for view and actions
    @order_item = @order.order_menu_items.select(:id, :order_id, :menu_item_id, :quantity).find(params[:id])
  end

  # Strong params for creating/updating an instance of OrderMenuItem
  def order_item_params
    return params.require(:order_menu_item).permit(:order_id, :menu_item_id, :quantity)
  end

end
