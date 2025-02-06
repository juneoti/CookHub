package com.dishcovery.project.controller;

import com.dishcovery.project.domain.RecipeBoardStepVO;
import com.dishcovery.project.domain.RecipeBoardVO;
import com.dishcovery.project.domain.RecipeDetailVO;
import com.dishcovery.project.domain.RecipeIngredientsDetailVO;
import com.dishcovery.project.service.RecipeBoardService;
import com.dishcovery.project.util.FileUploadUtil;
import com.dishcovery.project.util.Pagination;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/recipeboard")
@Log4j
public class RecipeBoardController {

    @Autowired
    RecipeBoardService recipeBoardService;

    @GetMapping("/list")
    public String list(
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            @RequestParam(value = "pageSize", defaultValue = "4") int pageSize,
            @RequestParam(value = "ingredientIds", required = false) String ingredientIdsStr,
            @RequestParam(value = "typeId", defaultValue = "1") Integer typeId,
            @RequestParam(value = "situationId", defaultValue = "1") Integer situationId,
            @RequestParam(value = "methodId", defaultValue = "1") Integer methodId,
            Model model) {

        // Pagination 설정
        Pagination pagination = new Pagination(pageNum, pageSize);
        pagination.setIngredientIdsFromString(ingredientIdsStr);
        pagination.setTypeId(typeId != null ? typeId : 1);
        pagination.setSituationId(situationId != null ? situationId : 1);
        pagination.setMethodId(methodId != null ? methodId : 1);

        // RecipeBoard 목록 및 관련 데이터 가져오기
        Map<String, Object> result = recipeBoardService.getRecipeBoardListWithFilters(
                recipeBoardService.preprocessPagination(pagination));

        // 모델에 데이터 추가
        model.addAllAttributes(result);
        model.addAttribute("selectedTypeId", typeId);
        model.addAttribute("selectedSituationId", situationId);
        model.addAttribute("selectedMethodId", methodId);
        model.addAttribute("ingredientIdsStr", pagination.getIngredientIdsAsString());
        model.addAttribute("selectedPageNum", pageNum);
        model.addAttribute("selectedIngredientIds", ingredientIdsStr != null ? Arrays.asList(ingredientIdsStr.split(",")) : List.of("1"));

        // 공통 레이아웃에 포함될 페이지 설정
        model.addAttribute("pageContent", "recipeboard/list.jsp");

        // 공통 레이아웃 반환
        return "layout";
    }


    @GetMapping("/register")
    public String register(Model model) {
        model.addAttribute("typesList", recipeBoardService.getAllTypes());
        model.addAttribute("methodsList", recipeBoardService.getAllMethods());
        model.addAttribute("situationsList", recipeBoardService.getAllSituations());
        model.addAttribute("ingredientsList", recipeBoardService.getAllIngredients());
        return "recipeboard/register";
    }


    @PostMapping("/register")
    public String registerRecipe(
        RecipeBoardVO recipeBoard,
        @RequestParam(value = "ingredientIds", required = false) List<Integer> ingredientIds,
        @RequestParam(value = "hashtags", required = false) String hashtags,
        @RequestPart(value = "thumbnail", required = false) MultipartFile thumbnail,
        @RequestParam(value = "stepDescription", required = false) List<String> stepDescriptions,
        @RequestPart(value = "stepImage", required = false) List<MultipartFile> stepImages,
        @RequestParam(value = "servings", required = false) String servings,
        @RequestParam(value = "time", required = false) String time,
        @RequestParam(value = "difficulty", required = false) String difficulty,
        @RequestParam(value = "stepOrder", required = false) List<Integer> stepOrders,
        @RequestParam(value = "ingredientName", required = false) List<String> ingredientNames,
        @RequestParam(value = "ingredientAmount", required = false) List<String> ingredientAmounts,
        @RequestParam(value = "ingredientUnit", required = false) List<String> ingredientUnits,
        @RequestParam(value = "ingredientNote", required = false) List<String> ingredientNotes
    ) throws IOException {
        
        log.info("Received ingredientNames: " + ingredientNames);
        log.info("Received ingredientAmounts: " + ingredientAmounts);
        log.info("Received ingredientUnits: " + ingredientUnits);
        log.info("Received ingredientNotes: " + ingredientNotes);

        List<RecipeIngredientsDetailVO> ingredientDetails = new ArrayList<>();
        if (ingredientNames != null) {
            for (int i = 0; i < ingredientNames.size(); i++) {
                RecipeIngredientsDetailVO detail = new RecipeIngredientsDetailVO();
                detail.setIngredientName(ingredientNames.get(i));
                  if(ingredientAmounts != null && i < ingredientAmounts.size()){
                          detail.setIngredientAmount(ingredientAmounts.get(i));
                      }
                  if(ingredientUnits != null && i < ingredientUnits.size()){
                         detail.setIngredientUnit(ingredientUnits.get(i));
                      }
                   if(ingredientNotes != null && i < ingredientNotes.size()){
                        detail.setIngredientNote(ingredientNotes.get(i));
                     }
                ingredientDetails.add(detail);
                log.info("Ingredient Detail: " + detail);
            }
        }

        List<RecipeBoardStepVO> steps = new ArrayList<>();
        if (stepDescriptions != null && !stepDescriptions.isEmpty()) {
            for (int i = 0; i < stepDescriptions.size(); i++) {
                RecipeBoardStepVO step = new RecipeBoardStepVO();
                if (stepOrders != null && i < stepOrders.size()) {
                    Integer order = stepOrders.get(i);
                    step.setStepOrder(order == null ? i + 1 : order);
                } else {
                    step.setStepOrder(i + 1);
                }
                step.setStepDescription(stepDescriptions.get(i));
                if (stepImages != null && i < stepImages.size() && stepImages.get(i) != null && !stepImages.get(i).isEmpty()) {
                    // 파일 경로는 실제 저장되는 경로로 변경해야 합니다.
                    String stepImageUrl = FileUploadUtil.saveFile("C:/uploads", stepImages.get(i));
                    step.setStepImageUrl(stepImageUrl);
                } else {
                    step.setStepImageUrl(null);
                }
                steps.add(step);
                log.info("Step info in controller: " + step);
            }
        }

        log.info("RecipeBoard value before createRecipe method called: " + recipeBoard);
        if (servings != null) {
            recipeBoard.setServings(servings);
        }
        if (time != null) {
            recipeBoard.setTime(time);
        }
        if (difficulty != null) {
            recipeBoard.setDifficulty(difficulty);
        }

        recipeBoardService.createRecipe(recipeBoard, ingredientIds, hashtags, thumbnail, steps, ingredientDetails);
        return "redirect:/recipeboard/list";
    }


    @GetMapping("/detail/{recipeBoardId}")
    public String getRecipeDetail(@PathVariable int recipeBoardId, Model model) {
        RecipeDetailVO detail = recipeBoardService.getRecipeDetailById(recipeBoardId);

        if (detail == null) {
            return "redirect:/recipeboard/list";
        }

        model.addAttribute("recipeBoard", detail.getRecipeBoard());
        model.addAttribute("typeName", detail.getTypeName());
        model.addAttribute("methodName", detail.getMethodName());
        model.addAttribute("situationName", detail.getSituationName());
        model.addAttribute("ingredients", detail.getIngredients());
        model.addAttribute("hashtags", detail.getHashtags());
        model.addAttribute("steps", detail.getRecipeSteps()); // 스텝 정보 추가
        model.addAttribute("ingredientDetails", recipeBoardService.getRecipeIngredientsDetailsByRecipeId(recipeBoardId));
        return "recipeboard/detail";
    }

    @GetMapping("/update/{recipeBoardId}")
    public String updateForm(@PathVariable int recipeBoardId, Model model) {
        RecipeBoardVO recipeBoard = recipeBoardService.getByRecipeBoardId(recipeBoardId);
        if (recipeBoard == null) {
            return "redirect:/recipeboard/list";
        }

        model.addAttribute("recipeBoard", recipeBoard);
        model.addAttribute("selectedIngredientIds", recipeBoardService.getSelectedIngredientIdsByRecipeBoardId(recipeBoardId));
        model.addAttribute("typesList", recipeBoardService.getAllTypes());
        model.addAttribute("methodsList", recipeBoardService.getAllMethods());
        model.addAttribute("situationsList", recipeBoardService.getAllSituations());
        model.addAttribute("ingredientsList", recipeBoardService.getAllIngredients());
        model.addAttribute("hashtags", recipeBoardService.getHashtagsByRecipeBoardId(recipeBoardId));
        model.addAttribute("steps", recipeBoardService.getRecipeBoardStepsByBoardId(recipeBoardId)); // 스텝 정보 추가
        model.addAttribute("ingredientDetails", recipeBoardService.getRecipeIngredientsDetailsByRecipeId(recipeBoardId));
        return "recipeboard/update";
    }

    @PostMapping("/update")
    public String updateRecipe(
          RecipeBoardVO recipeBoard,
            @RequestParam(value = "ingredientIds", required = false) List<Integer> ingredientIds,
            @RequestParam(value = "hashtags", required = false) String hashtags,
            @RequestPart(value = "thumbnail", required = true) MultipartFile thumbnail,
             @RequestParam(value = "stepDescription", required = false) List<String> stepDescriptions,
            @RequestParam(value = "stepImage", required = false)  List<MultipartFile> stepImages,
             @RequestParam(value = "servings", required = false) String servings,
            @RequestParam(value = "time", required = false) String time,
             @RequestParam(value = "difficulty", required = false) String difficulty,
             @RequestParam(value = "stepOrder", required = false) List<Integer> stepOrders,
            @RequestParam(value = "deleteStepIds", required = false) List<Integer> deleteStepIds,
            @RequestParam(value="recipeIngredients", required = false, defaultValue = "[]") String recipeIngredientsJson
    ) throws IOException {
      try {
          ObjectMapper mapper = new ObjectMapper();
            List<RecipeIngredientsDetailVO> ingredientDetails = new ArrayList<>();
            if(recipeIngredientsJson != null && !recipeIngredientsJson.trim().isEmpty()){
                   ingredientDetails = mapper.readValue(recipeIngredientsJson, new TypeReference<List<RecipeIngredientsDetailVO>>(){});
            }

            List<RecipeBoardStepVO> steps = new ArrayList<>();
            if (stepDescriptions != null && !stepDescriptions.isEmpty()) {
                for (int i = 0; i < stepDescriptions.size(); i++) {
                    RecipeBoardStepVO step = new RecipeBoardStepVO();
                    if (stepOrders != null && i < stepOrders.size()) {
                        Integer order = stepOrders.get(i);
                        step.setStepOrder(order == null ? i + 1 : order);
                    } else {
                        step.setStepOrder(i + 1);
                    }
                    step.setStepDescription(stepDescriptions.get(i));
                    if (stepImages != null && i < stepImages.size() && stepImages.get(i) != null && !stepImages.get(i).isEmpty()) {
                        String stepImageUrl = FileUploadUtil.saveFile("C:/uploads", stepImages.get(i));
						step.setStepImageUrl(stepImageUrl);
                    } else {
                        step.setStepImageUrl(null);
                    }
                    steps.add(step);
                    log.info("step info in controller: " + step);
                }
            }

           log.info("RecipeBoard value before updateRecipe method called: " + recipeBoard);
                if(servings != null){
                     recipeBoard.setServings(servings);
               }
               if(time != null){
                    recipeBoard.setTime(time);
                }
              if(difficulty != null){
                   recipeBoard.setDifficulty(difficulty);
               }
            recipeBoardService.updateRecipe(0, recipeBoard, ingredientIds, hashtags, thumbnail, steps, deleteStepIds, ingredientDetails);
            return "redirect:/recipeboard/detail/" + recipeBoard.getRecipeBoardId();
       } catch (IllegalArgumentException e) {
            log.error("Error updating recipe: " + e.getMessage());
            return "redirect:/recipeboard/update/" + recipeBoard.getRecipeBoardId() + "?error=" + e.getMessage();
        }
    }


    @PostMapping("/delete/{recipeBoardId}")
    public String deleteRecipe(@PathVariable int recipeBoardId) {
       recipeBoardService.deleteRecipe(recipeBoardId);
        return "redirect:/recipeboard/list";
    }

    @GetMapping("/thumbnail/{recipeBoardId}")
    public ResponseEntity<?> getThumbnail(@PathVariable int recipeBoardId) {
         return recipeBoardService.getThumbnailByRecipeBoardId(recipeBoardId)
                 .map(resource -> ResponseEntity.ok(resource))
                 .orElseGet(() -> ResponseEntity.notFound().build());
    }
}