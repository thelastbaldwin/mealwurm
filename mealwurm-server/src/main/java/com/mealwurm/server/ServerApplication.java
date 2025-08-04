package com.mealwurm.server;

import com.github.javafaker.Faker;
import com.mealwurm.server.model.Ingredient;
import com.mealwurm.server.model.Recipe;
import com.mealwurm.server.model.User;
import com.mealwurm.server.repository.IngredientRepository;
import com.mealwurm.server.repository.RecipeRepository;
import com.mealwurm.server.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

import java.util.ArrayList;
import java.util.List;

@EnableJpaAuditing
@SpringBootApplication
public class ServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(ServerApplication.class, args);
	}

	@Bean
	public CommandLineRunner commandLineRunner(
			RecipeRepository recipeRepository,
			IngredientRepository ingredientRepository,
			UserRepository userRepository) {
		return args -> {
			Faker faker = new Faker();
			ArrayList<User> users = new ArrayList<>();
			// mock users
			for (int i = 0; i < 5; i++) {
				User user = User.builder()
						.username(faker.name().username())
						.build();

				users.add(userRepository.save(user));
			}

			// mock recipes
			for (int i = 0; i < 18; i++) {
				User user = users.get(i % users.size());

				Recipe recipeObj = Recipe.builder()
						.title(faker.dune().title())
						.user(users.get(i % users.size()))
						.instructions(String.join("\n", faker.lorem().paragraphs(2)))
						.prepTime(faker.number().numberBetween(10, 30))
						.cookTime(faker.number().numberBetween(20, 40))
						.build();

				Recipe recipe = recipeRepository.save(recipeObj);

				// make 3 fake ingredients
				Ingredient[] ingredients = {
						Ingredient.builder()
								.unit(Ingredient.Unit.NONE)
								.name(faker.dragonBall().character())
								.recipe(recipe)
								.quantity(faker.number().numberBetween(1, 5))
								.ingredientOrder(0)
								.build(),
						Ingredient.builder()
								.unit(Ingredient.Unit.NONE)
								.name(faker.dragonBall().character())
								.recipe(recipe)
								.modifier("divided")
								.quantity(faker.number().numberBetween(1, 5))
								.ingredientOrder(1)
								.build(),
						Ingredient.builder()
								.unit(Ingredient.Unit.NONE)
								.name(faker.dragonBall().character())
								.recipe(recipe)
								.quantity(faker.number().numberBetween(1, 5))
								.ingredientOrder(2)
								.build()
				};

				for (int j = 0; j < ingredients.length; j++) {
					ingredientRepository.save(ingredients[j]);
				}

			}

		};
	}
}
