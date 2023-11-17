class Public::CurrentCustomersController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end
  
  def update
    @customer = Customer.find(current_customer.id)
    @customer.update(customer_params)
    redirect_to public_current_customer_path
  end
  
  def confirm
    @customer = Customer.find(current_customer.id)
  end
  
  def unsubscribed
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: false)
    redirect_to root_path
  end
  
  private

  def customer_params
     params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :password, :password_confirmation, :is_active)
  end
  
end
