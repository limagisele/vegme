class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def success
    Payment.create!(order_id: session[:order_id], status: "Successful")
    session.delete(:order_id)
  end

  def webhook
    payment_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)
    order_id = payment.metadata.order_id
    user_id = payment.metadata.user_id
    p "Order ID:" + order_id
    p "User ID:" + user_id
  end
end
