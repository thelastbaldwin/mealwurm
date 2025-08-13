package com.mealwurm.server.controller;

import com.mealwurm.server.model.User;
import com.mealwurm.server.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;
import java.util.UUID;

@RestController
public class UserController {

    @Autowired
    UserService userService;

    @GetMapping("/users/{userId}")
    public ResponseEntity<User> getUser(@PathVariable UUID userId){
        Optional<User> user = userService.getUserById(userId);
        return ResponseEntity.status(user.isEmpty() ? HttpStatus.NOT_FOUND : HttpStatus.OK).body(user.orElse(null));
    }
}
