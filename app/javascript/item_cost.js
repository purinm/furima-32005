window.addEventListener('load', () => {

  // 要素取得
  const cost = document.getElementById("item-price")
  const tax = document.getElementById('add-tax-price')
  const profit = document.getElementById('profit')
 
  // イベント
  cost.addEventListener("input",() => {
    const cost_value = cost.value;
    const rate = 0.1;
    const Tax = cost_value * rate;
    const Profit = cost_value - Tax;
    
    // 表示
  tax.textContent = Tax;
  profit.textContent = Profit;
 });
});


 



