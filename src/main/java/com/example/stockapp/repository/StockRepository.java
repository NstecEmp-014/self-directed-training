package com.example.stockapp.repository;

import com.example.stockapp.entity.Stock;
import org.apache.ibatis.annotations.Mapper;


import java.util.List;

@Mapper
public interface StockRepository {
    List<Stock> findStocks(); // 全ての株を取得
    Stock findById(Integer id); // IDで株を取得
    void insertStock(Stock stock); // 新しい株を追加
    void updateStock(Stock stock); // 既存の株を更新
    void deleteStock(Integer id); // IDで株を削除
    int countByCode(String code); // 証券コードで株をカウント
}