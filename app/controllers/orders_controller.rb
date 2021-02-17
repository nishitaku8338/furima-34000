class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end

  def create
    @item = Item.find(params[:item_id])  # :tokenとrender action: :indexに関わる為記述が必要
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?  # バリデーションを確認
      @order_address.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :house_number,
      :building_name,
      :phone_number,
    ).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
