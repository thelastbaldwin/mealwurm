package com.mealwurm.server.repository;

import com.mealwurm.server.model.Ingredient;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface IngredientRepository extends JpaRepository<Ingredient, UUID> {

    @Transactional
    List<Ingredient> findAllByRecipeIdOrderByIngredientOrderDesc(UUID recipeId);
}
