class Public::CurrentCustomersController < ApplicationController
  def show
    @current_customer = Current_customer.find(params)
  end

  def edit
  end
  
  def confirm
    
  end
  
  def unsubscribed
    
  end
  
  private

  def current_customer_params
     params.require(:current_customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
  
end
