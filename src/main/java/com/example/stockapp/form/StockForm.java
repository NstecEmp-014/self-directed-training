package com.example.stockapp.form;

import lombok.Data;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;


@Data
public class StockForm {
    private Long id;
    @NotBlank
    private String name;
    @NotBlank
    private String code;
    @NotNull
    private Integer price;
}