const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); // PAY.JPテスト公開鍵のセット クレカ情報をPAYJP送信時に必須
     
 
  const form = document.getElementById("charge-form");  //フォームの全体の要素取得
  form.addEventListener("submit", (e) => {     //送信するとイベント発火
    e.preventDefault(); //デフォルトの送信キャンセル

    const formResult = document.getElementById("charge-form"); // フォームの要素を取得しformResultに入れる
    const formData = new FormData(formResult);  //jsで扱えるようにするFormDataオブジェクトとして生成
    
    // クレカ情報を取得し、変数cardに代入
    const card = {
      number: formData.get("purchase_address[number]"),
      cvc: formData.get("purchase_address[cvc]"),
      exp_month: formData.get("purchase_address[exp_month]"),
      exp_year: `20${formData.get("purchase_address[exp_year]")}`,
    };
   
    // カード情報をPAY.JP側に送りトークン化
    // 第一引数：PAY.JP側に送るカードの情報＝カード情報のオブジェクト 
    // 第二引数：トークンが送付後に実行する処理を、即時関数で
    Payjp.createToken(card, (status, response) => {
     
      if (status == 200) {  //送信成功したら
        const token = response.id;  // トークンの値を取得フォームに追加していく
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;   // inputタグ作成トークンの値を非表示
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      // クレジットカードの情報を削除
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      // フォームの情報をサーバーサイドに送信
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);

  