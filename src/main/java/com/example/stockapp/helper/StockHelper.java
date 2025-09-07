package com.example.stockapp.helper;

import com.example.stockapp.entity.Stock;
import com.example.stockapp.form.StockForm;

public class StockHelper {
    public static Stock convert(StockForm form) {
        Stock stock = new Stock();
        stock.setName(form.getName());
        stock.setCode(form.getCode());
        stock.setPrice(form.getPrice());
        stock.setDeleteFlag(0);
        return stock;
    }

    public static StockForm convert(Stock stock) {
        StockForm form = new StockForm();
        form.setId(stock.getId()); 
        form.setName(stock.getName());
        form.setCode(stock.getCode());
        form.setPrice(stock.getPrice());
        return form;
    }
}