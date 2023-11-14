class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @item_count = @items.total_count
  end
  
  def calculate_tax_included_price(price)
    (price * 1.1).floor
  end
  
  def show
    @item = Item.find(params[:id])
    @tax_included_price = calculate_tax_included_price(@item.price)
  end
  
  def new
    
  end
  
  def edit
    
  end
  
  private
  

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image)
  end
  
end
