class Public::CurrentCustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to public_current_customer_path(@customer.id)
  end
  
  def confirm
    @customer = Customer.find(params[:id])
  end
  
  def unsubscribed
    @customer = Customer.find(params[:id])
    @customer.update(is_active: false)
  end
  
  private

  def customer_params
     params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :password, :password_confirmation)
  end
  
end
