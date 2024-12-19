package com.dishcovery.project.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dishcovery.project.domain.IngredientsVO;
import com.dishcovery.project.domain.MethodsVO;
import com.dishcovery.project.domain.RecipeBoardVO;
import com.dishcovery.project.domain.RecipeIngredientsVO;
import com.dishcovery.project.domain.SituationsVO;
import com.dishcovery.project.domain.TypesVO;
import com.dishcovery.project.persistence.RecipeBoardMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class RecipeBoardServiceImple implements RecipeBoardService {

    private final RecipeBoardMapper recipeBoardMapper;
    private final Logger log = LoggerFactory.getLogger(RecipeBoardServiceImple.class);

    @Autowired
    public RecipeBoardServiceImple(RecipeBoardMapper recipeBoardMapper) {
        this.recipeBoardMapper = recipeBoardMapper;
    }

    @Override
    public List<RecipeBoardVO> getRecipeBoardList() {
        log.info("getRecipeBoardList() - Service 시작");
        List<RecipeBoardVO> recipeBoardList = recipeBoardMapper.getRecipeBoardList();
        log.info("getRecipeBoardList() - Service 종료, 게시글 목록: {}", recipeBoardList);
        return recipeBoardList;
    }

    @Override
    public RecipeBoardVO getRecipeBoardById(int recipeBoardId) {
         log.info("getRecipeBoardById() - Service 시작, recipeBoardId: {}", recipeBoardId);
        RecipeBoardVO recipeBoard = recipeBoardMapper.getByRecipeBoardId(recipeBoardId);
        log.info("getRecipeBoardById() - Service 종료, 게시글 정보: {}", recipeBoard);
        return recipeBoard;
    }

    @Override
    public String getTypeName(int typeId) {
        log.info("getTypeName() - Service 시작, typeId: {}", typeId);
        String typeName = recipeBoardMapper.getTypeName(typeId);
        log.info("getTypeName() - Service 종료, 타입 이름: {}", typeName);
        return typeName;
    }

    @Override
    public String getMethodName(int methodId) {
         log.info("getMethodName() - Service 시작, methodId: {}", methodId);
        String methodName = recipeBoardMapper.getMethodName(methodId);
        log.info("getMethodName() - Service 종료, 방법 이름: {}", methodName);
        return methodName;
    }

    @Override
    public String getSituationName(int situationId) {
        log.info("getSituationName() - Service 시작, situationId: {}", situationId);
        String situationName = recipeBoardMapper.getSituationName(situationId);
        log.info("getSituationName() - Service 종료, 상황 이름: {}", situationName);
        return situationName;
    }

    @Override
    public List<IngredientsVO> getIngredientsByRecipeId(int recipeBoardId) {
        log.info("getIngredientsByRecipeId() - Service 시작, recipeBoardId: {}", recipeBoardId);
        List<IngredientsVO> ingredients = recipeBoardMapper.getIngredientsByRecipeId(recipeBoardId);
        log.info("getIngredientsByRecipeId() - Service 종료, 재료 목록: {}", ingredients);
        return ingredients;
    }

    @Override
    @Transactional
    public void createRecipeBoard(RecipeBoardVO recipeBoard, List<Integer> ingredientIds) {
        log.info("createRecipeBoard() - Service 시작, recipeBoard: {}, ingredientIds: {}", recipeBoard, ingredientIds);

        // 시퀀스를 사용하여 ID를 가져옴
        int nextId = recipeBoardMapper.getNextRecipeBoardId();
        log.info("createRecipeBoard() - Service, 시퀀스에서 가져온 다음 ID: {}", nextId);
        recipeBoard.setRecipeBoardId(nextId);

        // 레시피 게시글 기본 정보 삽입
        log.info("createRecipeBoard() - Service, 게시글 정보 삽입 시작: {}", recipeBoard);
        recipeBoardMapper.insertRecipeBoard(recipeBoard);
        log.info("createRecipeBoard() - Service, 게시글 정보 삽입 완료");


         // 재료 정보를 연결 테이블에 저장
        if (ingredientIds != null && !ingredientIds.isEmpty()) {
            log.info("createRecipeBoard() - Service, 재료 목록 처리 시작, 재료 ID 목록: {}", ingredientIds);
            for (Integer ingredientId : ingredientIds) {
                RecipeIngredientsVO recipeIngredients = new RecipeIngredientsVO();
                recipeIngredients.setRecipeBoardId(recipeBoard.getRecipeBoardId());
                recipeIngredients.setIngredientId(ingredientId);
               log.info("createRecipeBoard() - Service, 재료 정보 삽입 시작,  재료 정보: {}", recipeIngredients);
                recipeBoardMapper.insertRecipeIngredient(recipeIngredients);
                 log.info("createRecipeBoard() - Service, 재료 정보 삽입 완료");
            }
            log.info("createRecipeBoard() - Service, 재료 목록 처리 완료");
        } else {
            log.info("createRecipeBoard() - Service, 재료 정보가 없습니다.");
        }
          log.info("createRecipeBoard() - Service 종료, 저장된 게시글 정보: {}", recipeBoard);
    }

    @Override
    @Transactional
    public void updateRecipeBoard(RecipeBoardVO recipeBoard, List<Integer> ingredientIds) {
         log.info("updateRecipeBoard() - Service 시작, recipeBoard: {}, ingredientIds: {}", recipeBoard, ingredientIds);
       // 기존 재료 정보 삭제
         log.info("updateRecipeBoard() - Service, 기존 재료 정보 삭제 시작,  recipeBoardId: {}",recipeBoard.getRecipeBoardId());
        recipeBoardMapper.deleteRecipeIngredientsByRecipeId(recipeBoard.getRecipeBoardId());
        log.info("updateRecipeBoard() - Service, 기존 재료 정보 삭제 완료");

         // 레시피 게시글 정보 수정
          log.info("updateRecipeBoard() - Service, 게시글 정보 수정 시작,  recipeBoard: {}",recipeBoard);
        recipeBoardMapper.update(recipeBoard);
        log.info("updateRecipeBoard() - Service, 게시글 정보 수정 완료");

        // 재료 정보를 연결 테이블에 저장
       if (ingredientIds != null && !ingredientIds.isEmpty()) {
           log.info("updateRecipeBoard() - Service, 재료 목록 처리 시작, 재료 ID 목록: {}", ingredientIds);
            for (Integer ingredientId : ingredientIds) {
                  RecipeIngredientsVO recipeIngredients = new RecipeIngredientsVO();
                   recipeIngredients.setRecipeBoardId(recipeBoard.getRecipeBoardId());
                   recipeIngredients.setIngredientId(ingredientId);
                 log.info("updateRecipeBoard() - Service, 재료 정보 삽입 시작, 재료 정보: {}", recipeIngredients);
                recipeBoardMapper.insertRecipeIngredient(recipeIngredients);
                   log.info("updateRecipeBoard() - Service, 재료 정보 삽입 완료");
            }
             log.info("updateRecipeBoard() - Service, 재료 목록 처리 완료");
        } else {
            log.info("updateRecipeBoard() - Service, 재료 정보가 없습니다.");
        }
         log.info("updateRecipeBoard() - Service 종료, 수정된 게시글 정보: {}", recipeBoard);
    }

    @Override
    @Transactional
    public void deleteRecipeBoard(int recipeBoardId) {
         log.info("deleteRecipeBoard() - Service 시작, recipeBoardId: {}", recipeBoardId);
        recipeBoardMapper.delete(recipeBoardId);
        log.info("deleteRecipeBoard() - Service 종료, 삭제된 게시글 ID: {}", recipeBoardId);
    }

    @Override
    public List<TypesVO> getAllTypes() {
        log.info("getAllTypes() - Service 시작");
        List<TypesVO> types = recipeBoardMapper.getAllTypes();
        log.info("getAllTypes() - Service 종료, 타입 목록: {}", types);
        return types;
    }

    @Override
    public List<MethodsVO> getAllMethods() {
        log.info("getAllMethods() - Service 시작");
        List<MethodsVO> methods = recipeBoardMapper.getAllMethods();
         log.info("getAllMethods() - Service 종료, 방법 목록: {}", methods);
        return methods;
    }

    @Override
    public List<SituationsVO> getAllSituations() {
        log.info("getAllSituations() - Service 시작");
        List<SituationsVO> situations = recipeBoardMapper.getAllSituations();
        log.info("getAllSituations() - Service 종료, 상황 목록: {}", situations);
        return situations;
    }

    @Override
    public List<IngredientsVO> getAllIngredients() {
        log.info("getAllIngredients() - Service 시작");
        List<IngredientsVO> ingredients = recipeBoardMapper.getAllIngredients();
        log.info("getAllIngredients() - Service 종료, 재료 목록: {}", ingredients);
        return ingredients;
    }
}