package com.phegon.phegonbank;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

@SpringBootApplication
@EnableAsync
@RequiredArgsConstructor
public class PhegonbankApplication {

    @PostConstruct
    public void init() {
        System.out.println("APPLICATION CREATED");
    }

    public static void main(String[] args) {
        SpringApplication.run(PhegonbankApplication.class, args);
    }

}
