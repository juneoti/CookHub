package com.dishcovery.project.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.dishcovery.project.domain.IngredientsVO;
import com.dishcovery.project.domain.MethodsVO;
import com.dishcovery.project.domain.RecipeBoardVO;
import com.dishcovery.project.domain.RecipeIngredientsVO;
import com.dishcovery.project.domain.SituationsVO;
import com.dishcovery.project.domain.TypesVO;

@Mapper
public interface RecipeBoardMapper {

    // 레시피 게시글 목록 가져오기
    List<RecipeBoardVO> getRecipeBoardList();

     // 레시피 게시글 상세 조회
    RecipeBoardVO getByRecipeBoardId(int recipeBoardId);

    // 레시피 타입 이름 가져오기
    String getTypeName(int typeId);

    // 레시피 방법 이름 가져오기
    String getMethodName(int methodId);

    // 레시피 상황 이름 가져오기
    String getSituationName(int situationId);

    // 레시피 게시글에 속한 재료 목록 가져오기
    List<IngredientsVO> getIngredientsByRecipeId(int recipeBoardId);
    
    // 다음 레시피 게시글 ID 가져오기
    int getNextRecipeBoardId();

    // 레시피 게시글 삽입
    void insertRecipeBoard(RecipeBoardVO recipeBoard);

    // 레시피 게시글 수정
    void update(RecipeBoardVO recipeBoard);

    // 레시피 게시글 삭제
    void delete(int recipeBoardId);

    // 레시피 게시글에 재료 삽입
     void insertRecipeIngredient(RecipeIngredientsVO recipeIngredients);

    // 레시피 게시글에 재료 삭제 (레시피 ID 기준)
    void deleteRecipeIngredientsByRecipeId(int recipeBoardId);
    
    // 모든 타입 정보 가져오기
    List<TypesVO> getAllTypes();

    // 모든 방법 정보 가져오기
    List<MethodsVO> getAllMethods();

    // 모든 상황 정보 가져오기
    List<SituationsVO> getAllSituations();

   // 모든 재료 정보 가져오기
   List<IngredientsVO> getAllIngredients();

}