package com.phegon.phegonbank.config;


import com.phegon.phegonbank.auth_users.entity.User;
import com.phegon.phegonbank.auth_users.repo.UserRepo;
import com.phegon.phegonbank.role.entity.Role;
import com.phegon.phegonbank.role.repo.RoleRepo;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import javax.sql.DataSource;
import java.util.List;

@Configuration
@RequiredArgsConstructor
public class DataInitializer {

    private final RoleRepo roleRepo;
    private final UserRepo userRepo;
    private final PasswordEncoder passwordEncoder;
    private final DataSource dataSource;

    @PostConstruct
    public void init() {
        System.out.println("******** DATAINITIALIZER CREATED ********");
    }

    @Bean
    CommandLineRunner loadData() {
        return args -> {
            System.out.println("RUNNER EXECUTED");
            System.out.println("========== DATA INITIALIZER RUNNING ==========");

            Role adminRole = roleRepo.findByName("ADMIN")
                    .orElseGet(() ->
                            roleRepo.save(
                                    Role.builder()
                                            .name("ADMIN")
                                            .build()
                            )
                    );

            Role customerRole = roleRepo.findByName("CUSTOMER")
                    .orElseGet(() ->
                            roleRepo.save(
                                    Role.builder()
                                            .name("CUSTOMER")
                                            .build()
                            )
                    );

            Role auditorRole = roleRepo.findByName("AUDITOR")
                    .orElseGet(() ->
                            roleRepo.save(
                                    Role.builder()
                                            .name("AUDITOR")
                                            .build()
                            )
                    );

            if (userRepo.findByEmail("admin@phegon.com").isEmpty()) {

                User admin = User.builder()
                        .firstName("System")
                        .lastName("Admin")
                        .email("admin@phegon.com")
                        .password(passwordEncoder.encode("admin123"))
                        .roles(List.of(adminRole))
                        .build();

                userRepo.save(admin);

            }
        };
    }
}