package com.mealwurm.server.service;

import com.mealwurm.server.model.User;
import com.mealwurm.server.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Service
public class UserService {
    @Autowired
    UserRepository userRepository;

    public Optional<User> getUserById(UUID id){
        try{
            return userRepository.findById(id);
        } catch(IllegalArgumentException illegalArgumentException){
            // handle badly formed UUID
            return Optional.empty();
        }
    }
}
