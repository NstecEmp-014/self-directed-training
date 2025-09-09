package com.example.stockapp.form;

import lombok.Data;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;


@Data
public class StockForm {
    private Integer id; // ID
    @NotBlank
    private String name; // 銘柄名
    @NotBlank
    private String code; // 証券コード
    @NotNull
    private Integer price; // 現在価格
}