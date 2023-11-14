class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
  end
  def new
    @item = Item.new
  end
  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item)
  end
  
  def calculate_tax_included_price(price)
    (price * 1.1).floor
  end
  
  def show
    @item = Item.find(params[:id])
    @tax_included_price = calculate_tax_included_price(@item.price)
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to admin_item_path(item.id)
  end
  
  private
  
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image)
  end
end
