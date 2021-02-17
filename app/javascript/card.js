const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);     // PAY.JPテスト公開鍵
  const form = document.getElementById("charge-form");  // formの値全部取得する
  form.addEventListener("submit", (e) => {              // eは、フォームの値が送信された時をeに代入している。
    e.preventDefault();                                 // 通常のRuby on Railsにおけるフォーム送信処理はキャンセル。
    console.log("フォーム送信時にイベント発火")
  });
};

window.addEventListener("load", pay);