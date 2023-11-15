class Admin::CustomersController < ApplicationController
  def index
    @cutomers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to admin_customer_path(customer.id)
  end
  
  private
  
  def costomer_params
    params.require(:costomer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
  
end
