class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
  end

  private

  def item_params
    params.require(:item).permit(:user_id, :name, :description, :category_id, :condition_id, :delivery_fee_id, :days_to_sip_id, :prefecture_id, :cost)
  end
end
