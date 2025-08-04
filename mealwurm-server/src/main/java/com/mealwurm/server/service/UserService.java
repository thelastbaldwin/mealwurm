package com.mealwurm.server.service;

import com.mealwurm.server.model.User;
import com.mealwurm.server.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class UserService {
    @Autowired
    UserRepository userRepository;

    public User addUser(String username, String email, String password) {
        User newUser = User.builder()
                .username(username)
                .build();

        return userRepository.save(newUser);
    }

    // get this information from the jwt
    public String getCurrentUserId() {
        return "";
    }
}
