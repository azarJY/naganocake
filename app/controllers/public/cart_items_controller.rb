class Public::CartItemsController < ApplicationController
  
  def create
    item = Item.find(params[:item_id])
    @cart_item = CartItem.find_by(item_id: item.id, customer_id: current_customer.id)
  
    if @cart_item.present?
      @cart_item.amount += params[:amount].to_i
      if @cart_item.save
        flash[:notice] = "商品がカートに追加されました"
        redirect_to public_cart_items_path
      else
        flash[:notice] = "カートへの追加に失敗しました"
        @cart_items = CartItem.all
        render :index
      end
    else
      @cart_item = CartItem.new(item_id: item.id, customer_id: current_customer.id, amount: params[:amount])
      if @cart_item.save
        flash[:notice] = "商品がカートに追加されました"
        redirect_to public_cart_items_path
      else
        flash[:notice] = "カートへの追加に失敗しました"
        @cart_items = CartItem.all
        render :index
      end
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
