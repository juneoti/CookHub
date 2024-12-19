package com.dishcovery.project.controller;

import com.dishcovery.project.domain.*;
import com.dishcovery.project.service.RecipeBoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/recipeboard")
public class RecipeBoardController {

    private final RecipeBoardService recipeBoardService;
    private final Logger log = LoggerFactory.getLogger(RecipeBoardController.class);


    @Autowired
    public RecipeBoardController(RecipeBoardService recipeBoardService) {
        this.recipeBoardService = recipeBoardService;
    }


    @GetMapping("/list")
    public String getRecipeBoardList(Model model) {
        log.info("getRecipeBoardList() - Controller 시작");
        List<RecipeBoardVO> recipeBoardList = recipeBoardService.getRecipeBoardList();
        log.info("getRecipeBoardList() - Controller 종료, 게시글 목록: {}", recipeBoardList);
        model.addAttribute("recipeBoardList", recipeBoardList);
        return "/recipeboard/list";
    }
      
    @GetMapping("/detail")
    public String getRecipeBoardDetail(@RequestParam("recipeBoardId") int recipeBoardId, Model model) {
        log.info("getRecipeBoardDetail() - Controller 시작, recipeBoardId: {}", recipeBoardId);
        RecipeBoardVO recipeBoard = recipeBoardService.getRecipeBoardById(recipeBoardId);
         if(recipeBoard == null) {
          log.warn("getRecipeBoardDetail() - Controller, 해당 게시글이 존재하지 않습니다. recipeBoardId: {}",recipeBoardId);
         return "redirect:/recipeboard/list";
        }
         log.info("getRecipeBoardDetail() - Controller, 게시글 정보: {}", recipeBoard);
        String typeName = recipeBoardService.getTypeName(recipeBoard.getTypeId());
        log.info("getRecipeBoardDetail() - Controller, 타입 이름: {}", typeName);
        String methodName = recipeBoardService.getMethodName(recipeBoard.getMethodId());
         log.info("getRecipeBoardDetail() - Controller, 방법 이름: {}", methodName);
        String situationName = recipeBoardService.getSituationName(recipeBoard.getSituationId());
          log.info("getRecipeBoardDetail() - Controller, 상황 이름: {}", situationName);
         List<IngredientsVO> ingredients = recipeBoardService.getIngredientsByRecipeId(recipeBoardId);
         log.info("getRecipeBoardDetail() - Controller, 재료 목록: {}", ingredients);
        model.addAttribute("recipeBoard", recipeBoard);
        model.addAttribute("typeName", typeName);
        model.addAttribute("methodName", methodName);
        model.addAttribute("situationName", situationName);
        model.addAttribute("ingredients", ingredients);
        log.info("getRecipeBoardDetail() - Controller 종료");
        return "/recipeboard/detail";
    }

     @GetMapping("/register")
    public String registerForm(Model model) {
         log.info("registerForm() - Controller 시작");
          List<TypesVO> types = recipeBoardService.getAllTypes();
          log.info("registerForm() - Controller, 타입 목록: {}", types);
         List<MethodsVO> methods = recipeBoardService.getAllMethods();
          log.info("registerForm() - Controller, 방법 목록: {}", methods);
         List<SituationsVO> situations = recipeBoardService.getAllSituations();
          log.info("registerForm() - Controller, 상황 목록: {}", situations);
         List<IngredientsVO> ingredients = recipeBoardService.getAllIngredients();
         log.info("registerForm() - Controller, 재료 목록: {}", ingredients);
         model.addAttribute("types", types);
        model.addAttribute("methods", methods);
        model.addAttribute("situations", situations);
        model.addAttribute("ingredients", ingredients);
        log.info("registerForm() - Controller 종료");
        return "/recipeboard/register";
    }

    @PostMapping("/register")
    public String registerPOST(RecipeBoardVO recipeBoard, @RequestParam(value="ingredientIds", required = false) List<Integer> ingredientIds) {
         log.info("registerPOST() - Controller 시작, 게시글 정보: {}, 재료 ID 목록: {}", recipeBoard, ingredientIds);
        recipeBoardService.createRecipeBoard(recipeBoard, ingredientIds);
        log.info("registerPOST() - Controller 종료, 저장된 게시글 ID: {}", recipeBoard.getRecipeBoardId());
        return "redirect:/recipeboard/list";
    }


     @GetMapping("/modify")
    public String modifyForm(@RequestParam("recipeBoardId") int recipeBoardId, Model model) {
          log.info("modifyForm() - Controller 시작, recipeBoardId: {}", recipeBoardId);
         RecipeBoardVO recipeBoard = recipeBoardService.getRecipeBoardById(recipeBoardId);
          if(recipeBoard == null) {
           log.warn("modifyForm() - Controller, 해당 게시글이 존재하지 않습니다. recipeBoardId: {}",recipeBoardId);
           return "redirect:/recipeboard/list";
          }
          log.info("modifyForm() - Controller, 게시글 정보: {}", recipeBoard);
        List<TypesVO> types = recipeBoardService.getAllTypes();
         log.info("modifyForm() - Controller, 타입 목록: {}", types);
        List<MethodsVO> methods = recipeBoardService.getAllMethods();
          log.info("modifyForm() - Controller, 방법 목록: {}", methods);
        List<SituationsVO> situations = recipeBoardService.getAllSituations();
          log.info("modifyForm() - Controller, 상황 목록: {}", situations);
         List<IngredientsVO> ingredients = recipeBoardService.getAllIngredients();
          log.info("modifyForm() - Controller, 재료 목록: {}", ingredients);
        List<IngredientsVO> selectedIngredients = recipeBoardService.getIngredientsByRecipeId(recipeBoardId);
         log.info("modifyForm() - Controller, 선택된 재료 목록: {}", selectedIngredients);
        model.addAttribute("recipeBoard", recipeBoard);
         model.addAttribute("types", types);
        model.addAttribute("methods", methods);
        model.addAttribute("situations", situations);
        model.addAttribute("ingredients", ingredients);
         model.addAttribute("selectedIngredients", selectedIngredients);
         log.info("modifyForm() - Controller 종료");
        return "/recipeboard/modify";
    }

    @PostMapping("/modify")
    public String modifyPOST(RecipeBoardVO recipeBoard, @RequestParam(value="ingredientIds", required = false) List<Integer> ingredientIds) {
        log.info("modifyPOST() - Controller 시작, 게시글 정보: {}, 재료 ID 목록: {}", recipeBoard, ingredientIds);
        recipeBoardService.updateRecipeBoard(recipeBoard, ingredientIds);
         log.info("modifyPOST() - Controller 종료, 수정된 게시글 ID: {}", recipeBoard.getRecipeBoardId());
        return "redirect:/recipeboard/detail?recipeBoardId=" + recipeBoard.getRecipeBoardId();
    }


    @PostMapping("/delete")
    public String delete(@RequestParam("recipeBoardId") int recipeBoardId) {
          log.info("delete() - Controller 시작, recipeBoardId: {}", recipeBoardId);
        recipeBoardService.deleteRecipeBoard(recipeBoardId);
         log.info("delete() - Controller 종료, 삭제된 게시글 ID: {}", recipeBoardId);
        return "redirect:/recipeboard/list";
    }


}