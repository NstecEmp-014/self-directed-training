package com.example.stockapp.service;

import com.example.stockapp.entity.Stock;
import com.example.stockapp.repository.StockRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class StockServiceImpl implements StockService {

    @Autowired
    private StockRepository stockRepository;

    @Override
    public List<Stock> findStocks() {
        return stockRepository.findStocks();
    }

    @Override
    public Stock findById(Long id) {
        return stockRepository.findById(id);
    }

    @Override
    @Transactional
    public void createStock(Stock stock) {
        stockRepository.insertStock(stock);
    }

    @Override
    @Transactional
    public void updateStock(Long id, Stock stock) {
        stock.setId(id);
        stockRepository.updateStock(stock);
    }

    @Override
    @Transactional
    public void deleteStock(Long id) {
        stockRepository.deleteStock(id);
    }

    @Override
    public boolean existsByCode(String code) {
        return stockRepository.countByCode(code) > 0;
    }
}