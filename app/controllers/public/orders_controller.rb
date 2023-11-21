class Public::OrdersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @customer = current_customer
  end

  def confirm
    if params[:order][:address_id] == "0"
    address = current_customer.address_display

    elsif params[:order][:address_id] == "1"
    address_id = params[:order][:address_id]

    elsif params[:order][:address_id] == "2"
    order_params = params.require(:order).permit(:postal_code, :address, :name)
    postal_code = order_params[:postal_code]
    address = order_params[:address]
    name = order_params[:name]

    new_order = Order.new(order_params)
    new_order.save

    else
      render :new
    end
  end

  def completed

  end

  def create
  end
  
  private
  
  def order_params
    params.require(:order).permit(:postal_code, :address, :name)
  end
  
end
