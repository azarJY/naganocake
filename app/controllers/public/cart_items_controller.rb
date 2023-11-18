class Public::CartItemsController < ApplicationController
  
  def create
    @cart_item = Cart_item.new(cart_item_params[:item_id])
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
      flash[:notice] = "商品がカートに追加されました"
      redirect_to public_cart_items_path
    else
      flash[:notice] = "カートへの追加に失敗しました"
      @cart_items = Cart_item.all
      render :index
    end
  end
  
  def index
    @cart_items = Cart_item.all
  end
  
  def update
    @cart_item = Cart_item.find(params[:id])
    if @cart_item.update(cart_item_params)
       flash[:notice] = "変更が完了しました"
       redirect_to public_cart_items_path
    else
      @cart_items = Cart_item.all
      render :index
    end
  end
  
  def destroy
    cart_item = Cart_item.find(params[:id])
    cart_item.destroy
    redirect_to public_cart_items_path
  end
  
  def destroy_all
    current_customer.cart_items.destroy_all
  end
  
  private
 
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
