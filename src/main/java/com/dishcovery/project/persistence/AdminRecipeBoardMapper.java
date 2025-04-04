package com.dishcovery.project.persistence;

import java.util.List;

import com.dishcovery.project.domain.HashtagsVO;
import com.dishcovery.project.domain.IngredientsVO;
import com.dishcovery.project.domain.MethodsVO;
import com.dishcovery.project.domain.RecipeBoardStepVO;
import com.dishcovery.project.domain.RecipeBoardVO;
import com.dishcovery.project.domain.RecipeHashtagsVO;
import com.dishcovery.project.domain.RecipeIngredientsDetailVO;
import com.dishcovery.project.domain.RecipeIngredientsVO;
import com.dishcovery.project.domain.SituationsVO;
import com.dishcovery.project.domain.TypesVO;
import com.dishcovery.project.util.Pagination;

public interface AdminRecipeBoardMapper {

    // Recipe CRUD
    RecipeBoardVO getByRecipeBoardId(int recipeBoardId);
    int getNextRecipeBoardId();
    void insertRecipeBoard(RecipeBoardVO recipeBoard);
    void updateRecipeBoard(RecipeBoardVO recipeBoard);
    void deleteRecipeBoard(int recipeBoardId);

    // Recipe Ingredient Detail
    List<RecipeIngredientsDetailVO> getIngredientsDetailByRecipeId(int recipeBoardId);
    void insertRecipeIngredientsDetail(RecipeIngredientsDetailVO detail);
    void deleteRecipeIngredientsDetailsByRecipeId(int recipeBoardId);

    // Ingredients
    List<IngredientsVO> getIngredientsByRecipeId(int recipeBoardId);
    void insertRecipeIngredient(RecipeIngredientsVO recipeIngredient);
    void deleteRecipeIngredientsByRecipeId(int recipeBoardId);

    // Dropdown Data
    List<TypesVO> getAllTypes();
    List<MethodsVO> getAllMethods();
    List<SituationsVO> getAllSituations();
    List<IngredientsVO> getAllIngredients();

    String getTypeName(int typeId);
    String getMethodName(int methodId);
    String getSituationName(int situationId);

    // Pagination and Filtering
    List<RecipeBoardVO> selectAllRecipes(Pagination pagination);
    int getTotalCount(Pagination pagination);

    // Recipe Steps
    void insertRecipeBoardStep(RecipeBoardStepVO recipeBoardStep);
    List<RecipeBoardStepVO> selectRecipeBoardStepsByRecipeBoardId(int recipeBoardId);
    RecipeBoardStepVO selectRecipeBoardStepByStepId(int stepId);
    void updateRecipeBoardStep(RecipeBoardStepVO recipeBoardStep);
    void deleteRecipeBoardStepByStepId(int stepId);
    void deleteRecipeBoardStepsByRecipeBoardId(int recipeBoardId);

    // Hashtags
    List<HashtagsVO> getHashtagsByRecipeId(int recipeBoardId);
    HashtagsVO getHashtagByName(String hashtagName);
    int getNextHashtagId();
    void insertHashtag(HashtagsVO hashtag);
    void insertRecipeHashtag(RecipeHashtagsVO recipeHashtag);
    void deleteRecipeHashtagsByRecipeBoardId(int recipeBoardId);
    int getRecipeCountByHashtagId(int hashtagId);
    void deleteHashtagByHashtagId(int hashtagId);
    void deleteRecipeHashtagsByRecipeBoardIdAndHashtagId(int recipeBoardId, int hashtagId);
    
    TypesVO getTypeById(int typeId);

    MethodsVO getMethodById(int methodId);

    SituationsVO getSituationById(int situationId);
    List<String> getHashtagNamesByRecipeId(int recipeBoardId);
}