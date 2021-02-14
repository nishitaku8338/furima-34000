class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  private

  def item_params
    params.require(:item).permit(
      :image,
      :item_name,
      :item_description,
      :category_id,
      :item_state_id,
      :postage_id,
      :region_id,
      :shipping_data_id,
      :price
    ).merge(user_id: current_user.id)
  end
end
