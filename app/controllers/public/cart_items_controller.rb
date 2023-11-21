class Public::CartItemsController < ApplicationController
  
  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to public_cart_items_path
    elsif @cart_item.save
      @cart_items = current_customer.cart_items.all
      redirect_to public_cart_items_path
    else
      render 'index'
    end
  end
  
  
  def index
    @cart_items = CartItem.all
    @total_price = 0
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
       flash[:notice] = "変更が完了しました"
       redirect_to public_cart_items_path
    else
      @cart_items = CartItem.all
      render :index
    end
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to public_cart_items_path
  end
  
  def destroy_all
    @cart_items = CartItem.all
    current_customer.cart_items.destroy_all
    redirect_to public_cart_items_path
  end
  
  private
 
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
