package com.example.stockapp.entity;

import lombok.Data;

@Data
public class Stock {
    private Integer id; // ID
    private String name; // 銘柄名
    private String code; // 証券コード
    private Integer price; // 現在価格
    private Integer deleteFlag; // 削除フラグ
}