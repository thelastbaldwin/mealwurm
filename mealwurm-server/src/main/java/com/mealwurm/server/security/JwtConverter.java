package com.mealwurm.server.security;

import org.springframework.core.convert.converter.Converter;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtClaimNames;
import org.springframework.security.oauth2.server.resource.authentication.ExpressionJwtGrantedAuthoritiesConverter;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.stream.Collectors;

@Component
public class JwtConverter implements Converter<Jwt, MealwurmAuthenticationToken> {

    private final ExpressionJwtGrantedAuthoritiesConverter authoritiesConverter = new ExpressionJwtGrantedAuthoritiesConverter(new SpelExpressionParser().parseRaw("[resource_access][mealwurm][roles]"));

    public JwtConverter() {
        authoritiesConverter.setAuthorityPrefix("ROLE_");
    }

    @Override
    public MealwurmAuthenticationToken convert(Jwt jwt) {
        Collection<? extends GrantedAuthority> authorities = extractKeycloakClientRoles(jwt);
        String userId = extractSub(jwt);

        return new MealwurmAuthenticationToken(jwt, authorities, userId);
    }


    private String extractSub(Jwt jwt) {
        return jwt.getClaim(JwtClaimNames.SUB);
    }

    private Collection<? extends GrantedAuthority> extractKeycloakClientRoles(Jwt jwt) {
        return authoritiesConverter.convert(jwt).stream().map(ga -> new SimpleGrantedAuthority(ga.getAuthority())).collect(Collectors.toSet());
    }
}

