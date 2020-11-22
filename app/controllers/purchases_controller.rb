class PurchasesController < ApplicationController

  def index
    @purchase = Pucrhase.new
  end

  def new
    @address = Address.new
  end


  def create
    # binding.pry
    @purchase = Purchase.new(purchase_params)
    if @purchase.valid?
      pay_item
      @purchase.save
      return redirect_to root_path
    else
      render 'index'
    end
  end


  # サーバーサイドでトークンの情報を受け取れるようする
  private
  def purchase_params
    params.require(:purchase).permit(:price).merge(token: params[:token])
  end

def pay_item
  # 秘密鍵代入した環境変数を呼び込み
  Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  # Payjp.api_key = sk_test_9abbf0ba20da54166aa2d51e # 自身のPAY.JPテスト秘密鍵
      Payjp::Charge.create(
        amount: order_params[:price],  # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
    end
end
