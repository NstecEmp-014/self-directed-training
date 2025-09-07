package com.example.stockapp.entity;

import lombok.Data;

@Data
public class Stock {
    private Long id;
    private String name;
    private String code;
    private Integer price;
    private Integer deleteFlag;
}