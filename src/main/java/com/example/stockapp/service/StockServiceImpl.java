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
    public List<Stock> findStocks() { // 全ての株を取得
        return stockRepository.findStocks(); // リポジトリのfindStocksメソッドを呼び出す
    }

    @Override
    public Stock findById(Integer id) { // IDで株を取得
        return stockRepository.findById(id); // リポジトリのfindByIdメソッドを呼び出す
    }

    @Override
    @Transactional
    public void createStock(Stock stock) { // 新しい株を追加
        stockRepository.insertStock(stock); // リポジトリのinsertStockメソッドを呼び出す
    }

    @Override 
    @Transactional
    public void updateStock(Integer id, Stock stock) { // 既存の株を更新
        stock.setId(id); // IDを設定
        stockRepository.updateStock(stock); // リポジトリのupdateStockメソッドを呼び出す
    }

    @Override
    @Transactional
    public void deleteStock(Integer id) { // IDで株を削除
        stockRepository.deleteStock(id); // リポジトリのdeleteStockメソッドを呼び出す
    }

    @Override
    public boolean existsByCode(String code) { // 証券コードで株が存在するか確認
        return stockRepository.countByCode(code) > 0; // リポジトリのcountByCodeメソッドを呼び出し、0より大きいか確認
    }
}