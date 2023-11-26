class Admin::HomesController < ApplicationController
  def top
    @order = Order.page(params[:page]).per(8)
    
  end
end
