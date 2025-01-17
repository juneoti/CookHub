package com.dishcovery.project.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.dishcovery.project.domain.*;
import com.dishcovery.project.util.Pagination;

@Mapper
@Repository
public interface RecipeBoardMapper {

    // RecipeBoard CRUD
    RecipeBoardVO getByRecipeBoardId(int recipeBoardId); // 특정 Recipe 조회
    void insertRecipeBoard(RecipeBoardVO recipeBoard); // Recipe 등록
    void updateRecipeBoard(RecipeBoardVO recipeBoard); // Recipe 업데이트
    void deleteRecipeBoard(int recipeBoardId); // Recipe 삭제

     // Recipe Ingredient Detail
    List<RecipeIngredientsDetailVO> getIngredientsDetailByRecipeId(int recipeBoardId); // 특정 레시피의 재료 상세 정보 조회
    void insertRecipeIngredientsDetail(RecipeIngredientsDetailVO recipeIngredientDetail); // 레시피 재료 상세 정보 추가
    void deleteRecipeIngredientsDetailsByRecipeId(int recipeBoardId); // 특정 레시피의 모든 재료 상세 정보 삭제

    // Recipe Ingredients
    List<IngredientsVO> getAllIngredients(); // 모든 재료 조회
    List<IngredientsVO> getIngredientsByRecipeId(int recipeBoardId); // 특정 Recipe의 재료 조회
    void insertRecipeIngredient(RecipeIngredientsVO recipeIngredients); // Recipe에 재료 추가
    void deleteRecipeIngredientsByRecipeId(int recipeBoardId); // 특정 Recipe의 모든 재료 삭제

    // Hashtags
    List<HashtagsVO> getHashtagsByRecipeId(int recipeBoardId); // 특정 Recipe의 해시태그 조회
    HashtagsVO getHashtagByName(String hashtagName); // 해시태그 이름으로 조회
    void insertHashtag(HashtagsVO hashtag); // 새 해시태그 추가
    void insertRecipeHashtag(RecipeHashtagsVO recipeHashtag); // Recipe-Hashtag 연결 추가
    void deleteRecipeHashtagsByRecipeId(int recipeBoardId); // 특정 Recipe의 모든 해시태그 연결 삭제
    int getRecipeCountByHashtagId(int hashtagId); // 해시태그가 연결된 다른 게시글 수 확인
    void deleteHashtagById(int hashtagId);  // 해시태그 삭제
        void deleteRecipeHashtagsByRecipeIdAndHashtagId(int recipeBoardId, int hashtagId);  // 게시글의 특정 해시태그 삭제
    List<String> getHashtagNamesByRecipeId(int recipeBoardId); // 특정 레시피의 해시태그 이름 조회

    
    // Types, Methods, Situations
    List<TypesVO> getAllTypes(); // 모든 Type 조회
    List<MethodsVO> getAllMethods(); // 모든 Method 조회
    List<SituationsVO> getAllSituations(); // 모든 Situation 조회
  
    String getTypeName(int typeId); // Type 이름 조회
    String getMethodName(int methodId); // Method 이름 조회
    String getSituationName(int situationId); // Situation 이름 조회

    // Pagination & Filtering
    List<RecipeBoardVO> getRecipeBoardListWithPaging(Pagination pagination); // 필터 및 페이징 적용 Recipe 조회
    int getTotalCountWithFilters(Pagination pagination); // 필터 적용된 Recipe 수 조회
    int getTotalCount(); // 전체 Recipe 수 조회

    // Sequence
    int getNextRecipeBoardId(); // SEQUENCE에서 다음 Recipe ID 가져오기
    int getNextHashtagId();  // SEQUENCE에서 다음 해시태그 ID 가져오기
    
    // Recipe Steps
    void insertRecipeBoardStep(RecipeBoardStepVO recipeBoardStep); // 레시피 스텝 추가
    List<RecipeBoardStepVO> selectRecipeBoardStepsByBoardId(int recipeBoardId); // 특정 게시글의 레시피 스텝 목록 조회
    RecipeBoardStepVO selectRecipeBoardStepByStepId(int stepId); // 특정 레시피 스텝 조회
    void updateRecipeBoardStep(RecipeBoardStepVO recipeBoardStep); // 레시피 스텝 수정
    void deleteRecipeBoardStepByStepId(int stepId); // 특정 스텝 삭제
    void deleteRecipeBoardStepsByBoardId(int recipeBoardId); // 특정 게시글의 모든 스텝 삭제
}