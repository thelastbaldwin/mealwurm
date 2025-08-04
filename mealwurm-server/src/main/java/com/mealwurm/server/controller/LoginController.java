package com.mealwurm.server.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LoginController {

    @RequestMapping("/login")
    public String login() {
        // should accept plain text username and password
        // hash the password and
        return "login";
    }
}
