const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);     // PAY.JPテスト公開鍵
  const form = document.getElementById("charge-form");  // formの値全部取得する
  form.addEventListener("submit", (e) => {              // eは、フォームの値が送信された時をeに代入している。
    e.preventDefault();                                 // 通常のRuby on Railsにおけるフォーム送信処理はキャンセル。
    // console.log("フォーム送信時にイベント発火")

    const formResult = document.getElementById("charge-form");  // "charge-form"というidでフォームの情報を取得
    const formData = new FormData(formResult);                  // FormDataオブジェクトとして生成

    const card = {
      number: formData.get("order_address[number]"),             // 生成したFormDataオブジェクトから、クレジットカードに関する情報を取得し、変数cardに代入するオブジェクトとして定義
      cvc: formData.get("order_address[cvc]"),                   // "order_address[number]"はhtmlのname属性の値を参照する
      exp_month: formData.get("order_address[exp_month]"),       // htmlのname属性は、ブラウザの検証を必ず使う
      exp_year: `20${formData.get("order_address[exp_year]")}`,  // 20$は2022年の最初の20の事
    };
  });
};

window.addEventListener("load", pay);