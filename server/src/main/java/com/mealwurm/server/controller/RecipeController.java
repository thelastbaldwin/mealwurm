package com.mealwurm.server.controller;

import com.mealwurm.server.model.Recipe;
import com.mealwurm.server.security.MealwurmAuthenticationToken;
import com.mealwurm.server.service.RecipeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
public class RecipeController {

    @Autowired
    RecipeService recipeService;

    @GetMapping("/recipes/{recipeId}")
    public ResponseEntity<Recipe> getRecipe(@PathVariable UUID recipeId) {
        Optional<Recipe> recipe = recipeService.getRecipeByRecipeId(recipeId);
        return ResponseEntity.status(recipe.isEmpty() ? HttpStatus.NOT_FOUND : HttpStatus.OK).body(recipe.orElse(null));
    }

    @GetMapping("/recipes")
    public List<Recipe> getRecipes(Authentication authentication) {
        MealwurmAuthenticationToken jwt = (MealwurmAuthenticationToken) authentication;
        UUID userId = jwt.getUserId();

        return recipeService.getRecipesByUserId(userId);
    }

    @PostMapping("/recipe")
    public void addRecipe(@RequestBody Recipe recipe) {
        recipeService.addRecipe(recipe);
    }

    // TODO: updateRecipe
    // TODO: deleteRecipe
}