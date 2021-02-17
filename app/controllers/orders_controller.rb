class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end

  def create
    binding.pry
    @item = Item.find(params[:item_id])  # :tokenとrender action: :indexに関わる為記述が必要
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?  # バリデーションを確認
      pay_item
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
    ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    # 秘密鍵をPAY.JP側へ送付
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # Payjpクラスのapi_keyインスタンスに秘密鍵を代入
    Payjp::Charge.create(
      amount: @item.price,         # 商品価格          ※必ず記述※
      card: order_params[:token],  # カードトークン     ※必ず記述※
      currency: 'jpy'              # 通貨の種類(日本円) ※必ず記述※
    )
  end
end
