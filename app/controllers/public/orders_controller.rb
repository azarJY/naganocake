class Public::OrdersController < ApplicationController
  def index
    @orders = current_customer.orders.all
  end

  def show
    @total_price = 0
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details
  end

  def new
    @customer = current_customer
    @order = Order.new
  end

  def confirm
    @order_detail = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
    @total_price = 0
    if params[:order][:address_select_id] == "0"
    @order = Order.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:address_select_id] == "1"
    @order = Order.new(order_params)
    @order.postal_code = Address.find(params[:order][:address_id]).postal_code
    @order.address = Address.find(params[:order][:address_id]).address
    @order.name = Address.find(params[:order][:address_id]).name
    
    elsif params[:order][:address_select_id] == "2"
    @order = Order.new(order_params)
    
    else
      render :new
    end
  end

  def create
    
    @order = current_customer.orders.new(order_params)
    @total_price = 0
    @order.save
    
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.price = cart_item.item.price
      @order_detail.order_id = @order.id
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to public_orders_completed_path
  end
  
  def completet
  end
  
  private
  
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment)
  end
end
