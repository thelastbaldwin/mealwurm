package com.mealwurm.server.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
@Entity
public class Recipe extends BaseEntity {
    private String title;
    @Column(columnDefinition = "TEXT")
    private String instructions;
    private int prepTime;
    private int cookTime;

    // one recipe to many ingredients
    @OneToMany(mappedBy = "recipe")
    private List<Ingredient> ingredients;

    // many recipes to one user
    @ManyToOne
    @JoinColumn(name = "user_id")
    @JsonIgnore
    private User user;

    // using the mappedBy property here indicates that Recipe is not the "owner" of
    // the relationship
    // this is because a tag has to have a recipe but a recipe doesn't necessarily
    // need a tag
    @ManyToMany(mappedBy = "recipes", fetch = FetchType.EAGER)
    private List<Tag> tags;
}
