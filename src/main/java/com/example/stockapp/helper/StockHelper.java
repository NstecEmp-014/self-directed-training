package com.example.stockapp.helper;

import com.example.stockapp.entity.Stock;
import com.example.stockapp.form.StockForm;

public class StockHelper { // StockとStockFormの変換を行うヘルパークラス
    public static Stock convert(StockForm form) {
        Stock stock = new Stock(); // StockFormをStockに変換
        stock.setName(form.getName()); // 銘柄名
        stock.setCode(form.getCode()); // 証券コード
        stock.setPrice(form.getPrice()); // 現在価格
        stock.setDeleteFlag(0); // 新規登録時は削除フラグを0に設定
        return stock;
    }

    public static StockForm convert(Stock stock) { // StockをStockFormに変換
        StockForm form = new StockForm(); // StockFormを生成
        form.setId(stock.getId());  // IDを設定
        form.setName(stock.getName()); // 銘柄名を設定
        form.setCode(stock.getCode()); // 証券コードを設定
        form.setPrice(stock.getPrice()); // 現在価格を設定
        return form;
    }
}