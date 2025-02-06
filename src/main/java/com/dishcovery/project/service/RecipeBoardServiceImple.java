package com.dishcovery.project.service;

import java.io.File;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.dishcovery.project.domain.*;
import com.dishcovery.project.persistence.RecipeBoardMapper;
import com.dishcovery.project.util.FileUploadUtil;
import com.dishcovery.project.util.PageMaker;
import com.dishcovery.project.util.Pagination;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class RecipeBoardServiceImple implements RecipeBoardService {

    @Autowired
    private RecipeBoardMapper mapper;

    @Override
    public RecipeBoardVO getByRecipeBoardId(int recipeBoardId) {
        log.info("Fetching recipe board entry with ID: " + recipeBoardId);
        return mapper.getByRecipeBoardId(recipeBoardId);
    }

    @Override
    public RecipeBoardVO findRecipeById(int id) {
        log.info("Fetching recipe board entry with ID: " + id);
        return mapper.getByRecipeBoardId(id);
    }


    @Override
      public Map<String, Object> findAllRecipes(Pagination pagination, Integer typeId, Integer situationId,
                                               Integer methodId, String ingredientIds, String hashtag) {
        pagination.setTypeId(typeId);
        pagination.setSituationId(situationId);
        pagination.setMethodId(methodId);
        pagination.setIngredientIdsFromString(ingredientIds);
        pagination.setHashtag(hashtag);
        pagination = preprocessPagination(pagination);

        Map<String, Object> result = getRecipeBoardListWithFilters(pagination);

        return result;
    }

    @Override
    @Transactional
    public void createRecipe(RecipeBoardVO recipeBoard, List<Integer> ingredientIds,
                            String hashtags, MultipartFile thumbnail,
                            List<RecipeBoardStepVO> steps, List<RecipeIngredientsDetailVO> ingredientsDetails) {
        log.info("createRecipe method param: " + recipeBoard);
        if (thumbnail == null || thumbnail.isEmpty()) {
            throw new IllegalArgumentException("Thumbnail is required for creating a recipe.");
        }
        try {

            // 썸네일 저장
            String thumbnailPath = saveThumbnail(thumbnail);
            recipeBoard.setThumbnailPath(thumbnailPath);
            recipeBoard.setMemberId("1");
            // 게시글 등록 (recipeBoardId는 MyBatis에서 자동 생성)
            mapper.insertRecipeBoard(recipeBoard);
            log.info("insertRecipeBoard called with: " + recipeBoard);

            // 레시피 ID 가져오기 (selectKey 사용)
            int recipeBoardId = recipeBoard.getRecipeBoardId();

            // 재료 정보 추가
            addIngredientsToRecipe(recipeBoardId, ingredientIds);

            // 재료 상세 정보 추가
            if (ingredientsDetails != null && !ingredientsDetails.isEmpty()) {
                addIngredientDetailsToRecipe(recipeBoardId, ingredientsDetails);
                log.info(ingredientsDetails + "1");
            }
            log.info(ingredientsDetails + "2");

            // 해시태그 처리
            saveHashtagsForRecipe(recipeBoardId, hashtags);

            // 스텝 정보 추가
            if (steps != null && !steps.isEmpty()) {
                saveRecipeSteps(recipeBoardId, steps);
            } else {
                log.info("steps is empty or null");
            }
        } catch (Exception e) {
            log.error("createRecipe failed " + e.getMessage(), e);
            throw new RuntimeException("Failed to create recipe with thumbnail and hashtags", e);
        }
    }

   @Override
   @Transactional
   public void updateRecipe(int id, RecipeBoardVO recipe, List<Integer> ingredientIds,
                         String hashtags, MultipartFile thumbnail,
                         List<RecipeBoardStepVO> steps, List<Integer> deleteStepIds,
                           List<RecipeIngredientsDetailVO> ingredientDetails) {
          log.info("updateRecipe method param: " + recipe);
        if (thumbnail == null || thumbnail.isEmpty()) {
            throw new IllegalArgumentException("Thumbnail is required for updating a recipe.");
         }
        try {
            // 기존 썸네일 삭제 및 새 썸네일 저장
            RecipeBoardVO existingRecipe = getByRecipeBoardId(id);
             if (existingRecipe != null && existingRecipe.getThumbnailPath() != null) {
                 FileUploadUtil.deleteFile("C:/uploads", existingRecipe.getThumbnailPath());
             }

             String thumbnailPath = saveThumbnail(thumbnail);
             recipe.setThumbnailPath(thumbnailPath);
            recipe.setRecipeBoardId(id);
             // 레시피 업데이트
            mapper.updateRecipeBoard(recipe);
            log.info("updateRecipeBoard called with: " + recipe);

            // 기존 재료 정보 삭제 및 추가
            mapper.deleteRecipeIngredientsByRecipeId(id);
            addIngredientsToRecipe(id, ingredientIds);

            // 기존 재료 상세 정보 삭제 및 추가
           mapper.deleteRecipeIngredientsDetailsByRecipeId(id);
            if (ingredientDetails != null && !ingredientDetails.isEmpty()) {
                addIngredientDetailsToRecipe(id, ingredientDetails);
            }
           // 기존 해시태그 삭제 및 추가
           saveHashtagsForRecipe(id, hashtags);
            // 스텝 삭제
            if (deleteStepIds != null && !deleteStepIds.isEmpty()) {
                for (int stepId : deleteStepIds) {
                    mapper.deleteRecipeBoardStepByStepId(stepId);
                 }
            }
            // 스텝 정보 추가
             if (steps != null && !steps.isEmpty()) {
                 saveRecipeSteps(id, steps);
             }
         } catch (Exception e) {
             log.error("updateRecipe failed " + e.getMessage(), e);
            throw new RuntimeException("Failed to update recipe with thumbnail and hashtags", e);
         }
    }
    
    
     @Override
     @Transactional
    public void updateRecipe(int id, RecipeBoardVO recipe) {
    	  try {
    		  recipe.setRecipeBoardId(id);
    		  mapper.updateRecipeBoard(recipe);
    	  }catch (Exception e) {
    		   log.error("updateRecipe failed " + e.getMessage(), e);
               throw new RuntimeException("Failed to update recipe", e);
    	  }
    	  
    }
    @Override
    @Transactional
    public void saveRecipeSteps(int recipeBoardId, List<RecipeBoardStepVO> steps) {
        try {
            if (steps == null || steps.isEmpty()) {
                return;
            }

            for (RecipeBoardStepVO step : steps) {
                // stepId가 null인지 체크
                if (step.getStepId() == null) {
                   // 새로운 스텝 처리
                    step.setRecipeBoardId(recipeBoardId);
                    mapper.insertRecipeBoardStep(step);
                    log.info("insertRecipeBoardStep called with: " + step);
                } else {
                   // 기존 스텝 수정 처리
                    mapper.updateRecipeBoardStep(step);
                    log.info("updateRecipeBoardStep called with: " + step);
                }
           }
        } catch (Exception e) {
            log.error("saveRecipeSteps failed " + e.getMessage(), e);
            throw new RuntimeException("Failed to save recipe steps", e);
        }
    }
    @Override
    @Transactional
    public void saveHashtagsForRecipe(int recipeBoardId, String hashtags) {
        try {
            // 기존 해시태그 연결 삭제
            mapper.deleteRecipeHashtagsByRecipeId(recipeBoardId);

            if (hashtags == null || hashtags.isBlank()) {
                return;
            }

            // 쉼표로 구분된 해시태그를 처리
            String[] hashtagArray = hashtags.split(",");
            for (String hashtagName : hashtagArray) {
                hashtagName = hashtagName.trim();

               if (!hashtagName.isEmpty()) {
                    // 해시태그 이름으로 검색
                   HashtagsVO existingHashtag = mapper.getHashtagByName(hashtagName);

                    if (existingHashtag == null) {
                       // 시퀀스를 사용해 새 해시태그 추가
                       int nextHashtagId = mapper.getNextHashtagId(); // 시퀀스 호출 메서드
                        HashtagsVO newHashtag = new HashtagsVO();
                        newHashtag.setHashtagId(nextHashtagId);
                        newHashtag.setHashtagName(hashtagName);

                       mapper.insertHashtag(newHashtag); // 새 해시태그 삽입
                       existingHashtag = newHashtag;
                    }

                   // Recipe-Hashtag 연결 추가
                   RecipeHashtagsVO recipeHashtag = new RecipeHashtagsVO();
                    recipeHashtag.setRecipeBoardId(recipeBoardId);
                   recipeHashtag.setHashtagId(existingHashtag.getHashtagId());
                   mapper.insertRecipeHashtag(recipeHashtag);
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to save hashtags for recipe", e);
        }
    }
    
    
     @Override
    @Transactional
    public void deleteHashtagForRecipe(int recipeBoardId, int hashtagId){
        try {
            mapper.deleteRecipeHashtagsByRecipeIdAndHashtagId(recipeBoardId, hashtagId);
            int count = mapper.getRecipeCountByHashtagId(hashtagId);
             if (count == 0) { // 다른 게시글과 연결되지 않은 경우
                  mapper.deleteHashtagById(hashtagId);
                }
        } catch (Exception e) {
            log.error("Failed to delete hashtag for recipe", e);
            throw new RuntimeException("Failed to delete hashtag for recipe", e);
        }
    }
    @Override
    public List<HashtagsVO> getHashtagsByRecipeBoardId(int recipeBoardId) {
        log.info("Fetching hashtags for recipe ID: " + recipeBoardId);
        return mapper.getHashtagsByRecipeId(recipeBoardId);
    }
    @Override
    @Transactional
    public void deleteRecipe(int recipeBoardId) {
        try {
           // 게시글에 연결된 해시태그 정보 가져오기
            List<HashtagsVO> hashtags = mapper.getHashtagsByRecipeId(recipeBoardId);
            log.info("Fetched hashtags for recipe ID: " + recipeBoardId + " : " + hashtags);
            // 게시글에 연결된 스텝 정보 가져오기
            List<RecipeBoardStepVO> steps = mapper.selectRecipeBoardStepsByBoardId(recipeBoardId);
            log.info("Fetched steps for recipe ID: " + recipeBoardId + " : " + steps);

            // 게시글 삭제 (해시태그 관계 포함)
            mapper.deleteRecipeIngredientsDetailsByRecipeId(recipeBoardId);
            log.info("deleteRecipeIngredientDetailsByRecipeId called with id: " + recipeBoardId);
            mapper.deleteRecipeIngredientsByRecipeId(recipeBoardId);
            log.info("deleteRecipeIngredientsByRecipeId called with id: " + recipeBoardId);
           mapper.deleteRecipeBoardStepsByBoardId(recipeBoardId);
             log.info("deleteRecipeBoardStepsByBoardId called with id: " + recipeBoardId);
            mapper.deleteRecipeHashtagsByRecipeId(recipeBoardId);
            log.info("deleteRecipeHashtagsByRecipeId called with id: " + recipeBoardId);
           mapper.deleteRecipeBoard(recipeBoardId);
            log.info("deleteRecipeBoard called with id: " + recipeBoardId);
            // 다른 게시글과 연결되지 않은 해시태그 삭제
            for (HashtagsVO hashtag : hashtags) {
                int count = mapper.getRecipeCountByHashtagId(hashtag.getHashtagId());
               log.info("Checking recipe count for hashtag id : " + hashtag.getHashtagId() + " count : " + count);
               if (count == 0) { // 다른 게시글과 연결되지 않은 경우
                     mapper.deleteHashtagById(hashtag.getHashtagId());
                    log.info("deleteHashtagById called with hashtag id : " + hashtag.getHashtagId());
                }
           }
        } catch (Exception e) {
            log.error("Failed to delete recipe", e);
           throw new RuntimeException("Failed to delete recipe", e);
        }
    }

    @Override
    public RecipeDetailVO getRecipeDetailById(int recipeBoardId) {
        log.info("Fetching recipe detail for ID: " + recipeBoardId);

        RecipeBoardVO recipeBoard = mapper.getByRecipeBoardId(recipeBoardId);
        if (recipeBoard == null) return null;

        RecipeDetailVO detail = new RecipeDetailVO();
        detail.setRecipeBoard(recipeBoard);
        detail.setTypeName(mapper.getTypeName(recipeBoard.getTypeId()));
        detail.setMethodName(mapper.getMethodName(recipeBoard.getMethodId()));
       detail.setSituationName(mapper.getSituationName(recipeBoard.getSituationId()));
        detail.setIngredients(mapper.getIngredientsByRecipeId(recipeBoardId));
        detail.setHashtags(mapper.getHashtagsByRecipeId(recipeBoardId));

        detail.setRecipeSteps(mapper.selectRecipeBoardStepsByBoardId(recipeBoardId)); // 스텝 정보 추가
        return detail;
    }


    @Override
    public List<IngredientsVO> getAllIngredients() {
        return mapper.getAllIngredients();
    }

    @Override
    public Set<Integer> getSelectedIngredientIdsByRecipeBoardId(int recipeBoardId) {
        log.info("Fetching selected ingredient IDs for recipe ID: " + recipeBoardId);
        return mapper.getIngredientsByRecipeId(recipeBoardId).stream().map(IngredientsVO::getIngredientId)
               .collect(Collectors.toSet());
   }

    @Override
    public List<RecipeIngredientsDetailVO> getRecipeIngredientsDetailsByRecipeId(int recipeBoardId){
         log.info("Fetching recipe ingredient details for ID: " + recipeBoardId);
        return mapper.getIngredientsDetailByRecipeId(recipeBoardId);
    }

   @Override
    public List<TypesVO> getAllTypes() {
        return mapper.getAllTypes();
   }

    @Override
    public List<MethodsVO> getAllMethods() {
        return mapper.getAllMethods();
    }

    @Override
    public List<SituationsVO> getAllSituations() {
        return mapper.getAllSituations();
    }

    @Override
    public List<RecipeBoardStepVO> getRecipeBoardStepsByBoardId(int recipeBoardId) {
        log.info("Fetching recipe steps for recipe ID: " + recipeBoardId);
         return mapper.selectRecipeBoardStepsByBoardId(recipeBoardId);
    }

    @Override
    public Pagination preprocessPagination(Pagination pagination) {
        if (pagination.getIngredientIds() != null && pagination.getIngredientIds().contains("1")) {
            pagination.setIngredientIds(null);
        }
        if (pagination.getTypeId() != null && pagination.getTypeId() == 1) {
            pagination.setTypeId(null);
        }
        if (pagination.getMethodId() != null && pagination.getMethodId() == 1) {
             pagination.setMethodId(null);
        }
        if (pagination.getSituationId() != null && pagination.getSituationId() == 1) {
            pagination.setSituationId(null);
       }

       return pagination;
    }

   @Override
    public Map<String, Object> getRecipeBoardListWithFilters(Pagination pagination) {
        Map<String, Object> result = new HashMap<>();
       result.put("recipeList", mapper.getRecipeBoardListWithPaging(pagination));
        result.put("allIngredients", getAllIngredients());
        result.put("allTypes", getAllTypes());
        result.put("allMethods", getAllMethods());
       result.put("allSituations", getAllSituations());

       int totalCount = mapper.getTotalCountWithFilters(pagination);
       PageMaker pageMaker = new PageMaker();
       pageMaker.setPagination(pagination);
        pageMaker.setTotalCount(totalCount);
       result.put("pageMaker", pageMaker);

        return result;
   }

    @Override
   public Optional<Resource> getThumbnailByRecipeBoardId(int recipeBoardId) {
        try {
           RecipeBoardVO recipeBoard = getByRecipeBoardId(recipeBoardId);

           if (recipeBoard == null || recipeBoard.getThumbnailPath() == null) {
                return Optional.empty();
           }

           File file = new File("C:/uploads/" + recipeBoard.getThumbnailPath());
            if (!file.exists()) {
               return Optional.empty();
           }
            return Optional.of(new FileSystemResource(file));
        } catch (Exception e) {
            log.error("Failed to fetch thumbnail", e);
            return Optional.empty();
        }
    }

    private String saveThumbnail(MultipartFile thumbnail) throws IOException {
        String uuid = UUID.randomUUID().toString();
       String extension = FileUploadUtil.subStrExtension(thumbnail.getOriginalFilename());
        String savedFileName = uuid + "." + extension;

        String datePath = FileUploadUtil.makeDatePath().replace("\\", "/");
       FileUploadUtil.saveFile("C:/uploads", thumbnail, savedFileName);

        return datePath + "/" + savedFileName;
    }

   private void deleteThumbnail(String thumbnailPath) {
       if (thumbnailPath != null) {
            FileUploadUtil.deleteFile("C:/uploads", thumbnailPath);
       }
   }

    private void addIngredientsToRecipe(int recipeBoardId, List<Integer> ingredientIds) {
        if (ingredientIds != null && !ingredientIds.isEmpty()) {
           ingredientIds.forEach(ingredientId -> {
                RecipeIngredientsVO recipeIngredient = new RecipeIngredientsVO();
                recipeIngredient.setRecipeBoardId(recipeBoardId);
               recipeIngredient.setIngredientId(ingredientId);
                mapper.insertRecipeIngredient(recipeIngredient);
            });
       }
    }
    private void addIngredientDetailsToRecipe(int recipeBoardId, List<RecipeIngredientsDetailVO> ingredientDetails) {
        log.info("addIngredientDetailsToRecipe called with recipeBoardId: " + recipeBoardId + ", ingredientDetails: " + ingredientDetails);
       if (ingredientDetails == null || ingredientDetails.isEmpty()){
           log.info("ingredientDetails is null or empty. skipping...");
            return;
       }
        ingredientDetails.forEach(ingredientDetail -> {
           ingredientDetail.setRecipeBoardId(recipeBoardId);
           // ingredientDetailId가 이미 설정되어 있다면, 해당 값 유지, 그렇지 않으면 null로 유지 (시퀀스에서 자동 생성)
           mapper.insertRecipeIngredientsDetail(ingredientDetail);
           log.info("insertRecipeIngredientsDetail called with detail : " + ingredientDetail);
        });
   }
    
   @Override
    public List<String> getHashtagNamesByRecipeBoardId(int recipeBoardId) {
        // 해시태그 VO 리스트를 가져오고, 이름 리스트로 변환
        return mapper.getHashtagsByRecipeId(recipeBoardId).stream().map(HashtagsVO::getHashtagName)
               .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void registerRecipe(RecipeBoardVO recipe) {
        try {
            mapper.insertRecipeBoard(recipe);
            log.info("insertRecipeBoard called with: " + recipe);


       } catch (Exception e) {
            log.error("registerRecipe failed " + e.getMessage(), e);
          throw new RuntimeException("Failed to register recipe", e);
        }
    }

    @Override
    public Map<String, Object> findAllRecipes(Pagination pagination) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<RecipeBoardVO> recipeList = mapper.selectAllRecipes(pagination);
            int totalCount = mapper.getTotalCount();

            PageMaker pageMaker = new PageMaker();
            pageMaker.setPagination(pagination);
            pageMaker.setTotalCount(totalCount);

            result.put("recipeList", recipeList);
            result.put("pageMaker", pageMaker);
        } catch (Exception e) {
             log.error("Error in findAllRecipes", e);
             return new HashMap<>();
        }
            return result;
    }

}