class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
  end

  def new
    @item = Item.new
  end


  private

  def item_params
    params.require(:item).permit(:image).merge(user_id: current_user.id)
  end
end