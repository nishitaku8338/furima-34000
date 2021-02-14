class ItemsController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
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

  def set_prototype
    @item = Item.find(params[:id])
  end

  def contributor_confirmation
    unless current_user == @item.user
      redirect_to root_path 
    end
  end
end
