class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    # @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      return redirect_to root_path
    end
    render "new"
  end

  # def show
  #   @item = Item.find(params[:id])
  # end


  private

  def item_params
    params.require(:item).permit(
      :image, :name, :description, :category_id, :condition_id, :delivery_fee_id, :days_to_sip_id, :prefecture_id, :cost
    ).merge(user_id: current_user.id)
  end
end
