package com.mealwurm.server.model;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.util.List;
import java.util.UUID;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "userEntity")
@EntityListeners(AuditingEntityListener.class)
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    private String username;
    private String firstName;
    private String lastName;
    private String email;

    // one user to many recipes
    @OneToMany(mappedBy = "user")
    private List<Recipe> recipes;

    // one user to many tags
    @OneToMany(mappedBy = "user")
    private List<Tag> tags;
}
