const pay = () => {
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {  // eは、フォームの値が送信された時をeに代入している。
    e.preventDefault();                     // 通常のRuby on Railsにおけるフォーム送信処理はキャンセル。現状「購入」ボタンをクリックしても、サーバーサイドへリクエストは送られない。
    console.log("フォーム送信時にイベント発火")
  });
};

window.addEventListener("load", pay);