class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]
  
  def success
    session.delete(:order_id)
  end

  def webhook
    payment_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)
    order_id = payment.metadata.order_id
    user_id = payment.metadata.user_id
    p "Order ID:" + order_id
    p "User ID:" + user_id
    render plain: "Success"
  end
end