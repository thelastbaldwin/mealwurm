package com.mealwurm.server.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@EqualsAndHashCode(callSuper = true)
@Data
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Ingredient extends BaseEntity {
    public enum Unit {
        NONE,
        CUP,
        GALLON,
        GRAM,
        KILOGRAM,
        LITER,
        MILLIGRAM,
        MILLILITER,
        OUNCE,
        PINT,
        POUND,
        QUART,
        TABLESPOON,
        TEASPOON
    }

    private String name;
    // divided, chilled, etc.
    private String modifier;
    private Unit unit;
    private float quantity;
    private int ingredientOrder;

    // many ingredients to one recipe
    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "recipe_id")
    private Recipe recipe;
}
