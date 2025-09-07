package com.example.stockapp.repository;

import com.example.stockapp.entity.Stock;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface StockRepository {
    List<Stock> findStocks();
    Stock findById(Long id);
    void insertStock(Stock stock);
    void updateStock(Stock stock);
    void deleteStock(Long id);
    int countByCode(String code);
}