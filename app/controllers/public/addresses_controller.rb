class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
  if @address.save
    flash[:notice] = "新しいアドレスが登録されました"
    redirect_to public_addresses_path
  else
    flash[:notice] = "登録に失敗しました"
    @addresses = Address.all
    render :index
  end
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    address = Address.find(params[:id])
    address.update(address_params)
    redirect_to public_addresses_path
  end
  
  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to public_addresses_path
  end
  
  private

  def address_params
     params.require(:address).permit(:postal_code, :address, :name)
  end
end
