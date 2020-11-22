class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_items, only: [:edit, :show,:update]

  def index
    @items = Item.all.order(created_at: :desc)
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
    render 'new'
  end

  def show
  end

  def edit
    unless  current_user.id == @item.user.id
    redirect_to root_path 
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render 'edit'
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.destroy
      redirect_to root_path 
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image, :name, :description, :category_id, :condition_id, :delivery_fee_id, :days_to_sip_id, :prefecture_id, :cost
    ).merge(user_id: current_user.id)
  end

  def set_items
    @item = Item.find(params[:id])
  end
end
