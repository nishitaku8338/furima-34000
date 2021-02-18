class OrdersController < ApplicationController
  before_action :authenticate_user!                       # ログアウト状態のユーザーが、URLを直接入力して商品購入ページに遷移しようとすると、商品の販売状況に関わらずログインページに遷移する
  before_action :set_item                                 # itemテーブルの情報(レコード)を取得する(order_addressはitemsテーブルと紐づいているため)
  #before_action :purchase_page, only: :index              # ログイン状態の出品者が、URLを直接入力して自身の出品した商品購入ページに遷移しようとすると、トップページに遷移する
  #before_action :sold_move                                # ログイン状態のユーザーが、URLを直接入力して売却済み商品の商品購入ページへ遷移しようとすると、トップページに遷移する

  def index
    @order_address = OrderAddress.new
  end

  def create
    #@item = Item.find(params[:item_id])  # :token(amount:商品の値段)とrender action: :indexに関わるため、記述が必要
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?  # バリデーションを確認
      pay_item                # 秘密鍵をPAY.JP側へ送付
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

  def set_item
    @item = Item.find(params[:item_id])
  end

  #def purchase_page                                      # URLで直接「購入ページ」に遷移しようとした時
  #  redirect_to root_path if current_user == @item.user  # ログインしているユーザー == itemテーブルのデータにitem.user.idと一致した商品があった場合、トップページに遷移する
  #end

  #def sold_move                                          # URLで直接「購入ページ」に遷移しようとした時
  #  redirect_to root_path if @item.order.present?        # orderテーブルにデータが存在する商品は、トップページに遷移する
  #end

  # http://localhost:3000/items/9/orders   hogeさんが出品した商品の購入ページ
  # http://localhost:3000/items/10/orders  fugaさんが出品した商品の購入ページ
end
