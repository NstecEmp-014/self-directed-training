package com.example.stockapp;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan("com.example.stockapp.repository")
@SpringBootApplication
public class SelfDirectedTrainingApplication {
    public static void main(String[] args) {
        SpringApplication.run(SelfDirectedTrainingApplication.class, args);
    }
}
