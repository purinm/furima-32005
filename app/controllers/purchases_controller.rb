class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item

  def index
    @purchase = Purchase.where(item_id: @item.id) # 購入記録に売却すみitem_idカラムの値があるか探しておく
    if @purchase.present? || current_user.id == @item.user.id  # 購入記録にそのitem_idがある、または出品者がURL入力から自品購入しようとしたら
       redirect_to root_path
    else
       @purchase_address = PurchaseAddress.new
    end
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid? # バリデーションの結果確認
      pay_item # バリデーションパスしたら支払い
      @purchase_address.save # 各テーブルへ保存
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:zip_code, :prefecture_id, :city, :street, :building, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def find_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # PAYJP側に決済情報を送るのに秘密鍵が必要,かぎを入れるクラス
    Payjp::Charge.create( # 決済に必要な情報を入れるクラス
      amount: @item.cost,
      card: purchase_params[:token],
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
