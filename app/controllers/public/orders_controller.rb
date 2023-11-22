class Public::OrdersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @customer = current_customer
    @order = Order.new
  end

  def confirm
    if params[:order][:address_select_id] == "0"
    @new_order = Order.new(order_params)
    new_order.postal_code = current_customer.postal_code
    new_order.address = current_customer.address
    new_order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:address_select_id] == "1"
    @new_order = Order.new(order_params)
    new_order.postal_code = Address.find(params[:order][:address_id]).postal_code
    new_order.address = Address.find(params[:order][:address_id]).address
    new_order.name = Address.find(params[:order][:address_id]).name
    
    elsif params[:order][:address_select_id] == "2"
    @new_order = Order.new(order_params)
    
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
    params.require(:order).permit(:postal_code, :address, :name, :payment_method)
  end
  
end
