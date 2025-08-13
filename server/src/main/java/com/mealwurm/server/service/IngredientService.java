package com.mealwurm.server.service;

import com.mealwurm.server.model.Ingredient;
import com.mealwurm.server.model.Recipe;
import com.mealwurm.server.repository.IngredientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@Service
public class IngredientService {

    @Autowired
    IngredientRepository ingredientRepository;

    public List<Ingredient> getIngredientsByRecipeId(String recipeId) {
        return ingredientRepository.findAllByRecipeIdOrderByIngredientOrderDesc(UUID.fromString(recipeId));
    }

    public void addIngredientsToRecipe(List<Ingredient> ingredients, Recipe recipe) {
        for (int i = 0; i < ingredients.size(); i++) {
            Ingredient ingredient = ingredients.get(i);
            ingredient.setRecipe(recipe);
            ingredient.setIngredientOrder(i);
            ingredientRepository.save(ingredient);
        }
    }
}
