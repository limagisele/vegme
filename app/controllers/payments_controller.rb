class PaymentsController < ApplicationController
  def success
    session.delete(:order_id)
  end
end
