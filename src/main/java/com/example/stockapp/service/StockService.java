package com.example.stockapp.service;

import com.example.stockapp.entity.Stock;
import java.util.List;

public interface StockService {
    List<Stock> findStocks();
    Stock findById(Long id);
    void createStock(Stock stock);
    void updateStock(Long id, Stock stock);
    void deleteStock(Long id);
    boolean existsByCode(String code);
}