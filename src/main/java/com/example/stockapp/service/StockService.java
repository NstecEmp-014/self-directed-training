package com.example.stockapp.service;

import com.example.stockapp.entity.Stock;
import java.util.List;

public interface StockService {
    List<Stock> findStocks(); // 全ての株を取得
    Stock findById(Integer id); // IDで株を取得
    void createStock(Stock stock); // 新しい株を追加
    void updateStock(Integer id, Stock stock); // 既存の株を更新
    void deleteStock(Integer id); // IDで株を削除
    boolean existsByCode(String code); // 証券コードで株が存在するか確認
}