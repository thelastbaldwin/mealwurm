package com.mealwurm.server.service;

import com.mealwurm.server.model.Recipe;
import com.mealwurm.server.repository.RecipeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class RecipeService {

    @Autowired
    IngredientService ingredientService;

    @Autowired
    RecipeRepository recipeRepository;

    public List<Recipe> getRecipesByUserId(UUID userId) {
        return recipeRepository.findAllByUserIdEquals(userId);
    }

    public Optional<Recipe> getRecipeByRecipeId(UUID recipeId) {
        try {
            return recipeRepository.findById(recipeId);
        } catch (IllegalArgumentException illegalArgumentException) {
            // handle badly formed UUID
            return Optional.empty();
        }
    }

    public Recipe addRecipe(Recipe recipe) {
        Recipe saved = recipeRepository.save(recipe);
        ingredientService.addIngredientsToRecipe(recipe.getIngredients(), saved);
        return recipe;
    }
}
