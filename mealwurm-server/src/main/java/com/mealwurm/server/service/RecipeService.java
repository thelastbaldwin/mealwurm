package com.mealwurm.server.service;

import com.mealwurm.server.model.Ingredient;
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

    // TODO: filter by user
    public List<Recipe> getRecipes() {
        return recipeRepository.findAll();
    }

    public Optional<Recipe> getRecipeByRecipeId(String recipeId) {
        try {
            var res = UUID.fromString(recipeId);
            return recipeRepository.findById(res);
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
