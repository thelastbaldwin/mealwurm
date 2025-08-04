package com.mealwurm.server.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Tag extends BaseEntity {
    private String name;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToMany
    @JoinTable(name = "recipes_tags", joinColumns = {
            @JoinColumn(name = "tag_id")
    }, inverseJoinColumns = {
            @JoinColumn(name = "recipe_id")
    })
    private List<Recipe> recipes;
}
