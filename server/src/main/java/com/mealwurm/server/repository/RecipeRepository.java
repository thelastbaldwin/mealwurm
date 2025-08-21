package com.mealwurm.server.repository;

import com.mealwurm.server.model.Ingredient;
import com.mealwurm.server.model.Recipe;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.UUID;

public interface RecipeRepository extends JpaRepository<Recipe, UUID> {

    @Transactional
//    @Query(value = "SELECT * FROM recipe r WHERE r.user_id = CAST(:userId AS VARCHAR)", nativeQuery = true)
    List<Recipe> findAllByUserIdEquals(@Param("userId") UUID userId);
}
