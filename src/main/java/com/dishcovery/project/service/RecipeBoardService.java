package com.dishcovery.project.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;

import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;

import com.dishcovery.project.domain.HashtagsVO;
import com.dishcovery.project.domain.IngredientsVO;
import com.dishcovery.project.domain.MethodsVO;
import com.dishcovery.project.domain.RecipeBoardStepVO;
import com.dishcovery.project.domain.RecipeBoardVO;
import com.dishcovery.project.domain.RecipeDetailVO;
import com.dishcovery.project.domain.RecipeIngredientsDetailVO;
import com.dishcovery.project.domain.SituationsVO;
import com.dishcovery.project.domain.TypesVO;
import com.dishcovery.project.util.Pagination;

public interface RecipeBoardService {

    // Recipe CRUD
    RecipeBoardVO getByRecipeBoardId(int recipeBoardId);
   void createRecipe(RecipeBoardVO recipeBoard, List<Integer> ingredientIds,
                       String hashtags, MultipartFile thumbnail,
                       List<RecipeBoardStepVO> steps, List<RecipeIngredientsDetailVO> ingredientDetails);
    void updateRecipe(RecipeBoardVO recipeBoard, List<Integer> ingredientIds,
                     String hashtags, MultipartFile thumbnail,
                     List<RecipeBoardStepVO> steps,List<Integer> deleteStepIds,
                     List<RecipeIngredientsDetailVO> ingredientDetails);
    void deleteRecipe(int recipeBoardId);

   // Recipe Details
    RecipeDetailVO getRecipeDetailById(int recipeBoardId);


    // Ingredients Management
    List<IngredientsVO> getAllIngredients(); // 모든 재료 조회
    Set<Integer> getSelectedIngredientIdsByRecipeBoardId(int recipeBoardId); // 레시피에 선택된 재료 ID 조회

    // Recipe Ingredient Details Management
     List<RecipeIngredientsDetailVO> getRecipeIngredientsDetailsByRecipeId(int recipeBoardId); // 특정 레시피의 모든 재료 상세 정보 조회

    // Hashtags Management
    List<HashtagsVO> getHashtagsByRecipeBoardId(int recipeBoardId); // 특정 레시피의 해시태그 조회
    void saveHashtagsForRecipe(int recipeBoardId, String hashtags); // 해시태그 저장
    List<String> getHashtagNamesByRecipeBoardId(int recipeBoardId);
   void deleteHashtagForRecipe(int recipeBoardId, int hashtagId); // 특정 해시태그 삭제

    // Types, Methods, Situations
    List<TypesVO> getAllTypes(); // 모든 Type 조회
    List<MethodsVO> getAllMethods(); // 모든 Method 조회
    List<SituationsVO> getAllSituations(); // 모든 Situation 조회

    // Pagination & Filtering
    Map<String, Object> getRecipeBoardListWithFilters(Pagination pagination); // 필터와 함께 레시피 목록 조회
    Pagination preprocessPagination(Pagination pagination); // 페이징 처리 준비

    // Thumbnail Management
    Optional<Resource> getThumbnailByRecipeBoardId(int recipeBoardId); // Optional로 썸네일 리소스 반환

    // Recipe Steps Management
     List<RecipeBoardStepVO> getRecipeBoardStepsByBoardId(int recipeBoardId); // 레시피 스텝 목록 조회
     void saveRecipeSteps(int recipeBoardId, List<RecipeBoardStepVO> steps);
}