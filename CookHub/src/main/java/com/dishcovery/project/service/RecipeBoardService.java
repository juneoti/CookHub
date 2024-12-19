package com.dishcovery.project.service;

import com.dishcovery.project.domain.*;

import java.util.List;

public interface RecipeBoardService {

    // 레시피 게시글 목록 가져오기
    List<RecipeBoardVO> getRecipeBoardList();

     // 레시피 게시글 상세 조회
    RecipeBoardVO getRecipeBoardById(int recipeBoardId);

    // 레시피 타입 이름 가져오기
    String getTypeName(int typeId);

     // 레시피 방법 이름 가져오기
    String getMethodName(int methodId);

     // 레시피 상황 이름 가져오기
    String getSituationName(int situationId);

    // 레시피 게시글에 속한 재료 목록 가져오기
    List<IngredientsVO> getIngredientsByRecipeId(int recipeBoardId);

    // 레시피 게시글 생성
    void createRecipeBoard(RecipeBoardVO recipeBoard, List<Integer> ingredientIds);

    // 레시피 게시글 수정
    void updateRecipeBoard(RecipeBoardVO recipeBoard, List<Integer> ingredientIds);

    // 레시피 게시글 삭제
    void deleteRecipeBoard(int recipeBoardId);

     // 모든 타입 정보 가져오기
    List<TypesVO> getAllTypes();

    // 모든 방법 정보 가져오기
    List<MethodsVO> getAllMethods();

    // 모든 상황 정보 가져오기
    List<SituationsVO> getAllSituations();

   // 모든 재료 정보 가져오기
   List<IngredientsVO> getAllIngredients();
}