package com.mealwurm.server.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;

import java.util.Collection;
import java.util.UUID;


public class MealwurmAuthenticationToken extends JwtAuthenticationToken {
    private final UUID userId;
    private final Collection<? extends GrantedAuthority> authorities;

    public MealwurmAuthenticationToken(
        Jwt jwt,
        Collection<? extends GrantedAuthority> authorities,
        String userId) {

        super(jwt, authorities);

        this.authorities = authorities;
        this.userId = UUID.fromString(userId);
    }

    public UUID getUserId(){
        return userId;
    }
    public Collection<? extends GrantedAuthority> getRoles() { return authorities; }
}
