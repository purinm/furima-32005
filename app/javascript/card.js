const pay = () => {
  // JavaScriptで環境変数を呼び込み
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  // Payjp.setPublicKey(pk_test_50c8d07153ef36fbc7a44dc4); // PAY.JPテスト公開鍵
 
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();

 // フォームの情報を取得し、それをFormDataオブジェクトとして生成
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    // クレジットカードに関する情報を取得し、変数cardに代入
    const card = {
      number: formData.get("order[number]"),
      cvc: formData.get("order[cvc]"),
      exp_month: formData.get("order[exp_month]"),
      exp_year: `20${formData.get("order[exp_year]")}`,
    };

    // カード情報をPAY.JP側に送りトークン化
    // 第一引数：PAY.JP側に送るカードの情報＝カード情報のオブジェクト 
    // 第二引数：PAY.JP側からトークンが送付された後に実行する処理を、アロー関数を用いた即時関数で記入
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        // トークンの値をフォームに含める
        const renderDom = document.getElementById("charge-form");
        // トークンの値を非表示
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        // debugger;
      }
      // クレジットカードの情報を削除
      document.getElementById("order_number").removeAttribute("name");
      document.getElementById("order_cvc").removeAttribute("name");
      document.getElementById("order_exp_month").removeAttribute("name");
      document.getElementById("order_exp_year").removeAttribute("name");
  // フォームの情報をサーバーサイドに送信
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);

  