package com.mealwurm.server.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;

import java.util.Collection;


public class MealwurmAuthenticationToken extends JwtAuthenticationToken {
    private final String userId;

    public MealwurmAuthenticationToken(
        Jwt jwt,
        Collection<? extends GrantedAuthority> authorities,
        String userId) {

        super(jwt, authorities);

        this.userId = userId;
    }

    public String getUserId(){
        return userId;
    }
}
