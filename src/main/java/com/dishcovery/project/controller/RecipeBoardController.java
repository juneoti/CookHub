package com.dishcovery.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dishcovery.project.domain.RecipeBoardVO;
import com.dishcovery.project.service.RecipeBoardService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/recipeboard")
@Log4j
public class RecipeBoardController {
	@Autowired
	private RecipeBoardService recipeBoardService;

	@GetMapping("/list")
	public String getRecipeBoardList(Model model) {
		log.info("getRecipeBoardList()");
		model.addAttribute("recipeBoardList", recipeBoardService.getBoardList());
		return "/list";
	}

	@GetMapping("/register")
	public String showRegisterPage(Model model) {
		model.addAttribute("typesList", recipeBoardService.getTypes());
		log.info("recipeBoardService.getTypes()");
		model.addAttribute("methodsList", recipeBoardService.getMethods());
		log.info("recipeBoardService.getMethods()");
		model.addAttribute("ingredientsList", recipeBoardService.getIngredients());
		log.info("recipeBoardService.getIngredients()");
		model.addAttribute("situationsList", recipeBoardService.getSituations());
		log.info("recipeBoardService.getSituations()");
		return "/register";
	}

	@PostMapping("/register")
	public String registerPOST(RecipeBoardVO recipeBoardVO) {
		log.info("registerPOST()");
		log.info("recipeBoardVO" + recipeBoardVO.toString());
		int result = recipeBoardService.createRecipeBoard(recipeBoardVO);
		log.info(result + "����");
		return "redirect:/board/list";
	}

	@GetMapping("/detail")
	public void detail(Integer recipeBoardId) {
	}

	@GetMapping("/modify")
	public void modifyGET(Model model, int recipeBoardId) {
		log.info("modifyGET()");
		RecipeBoardVO recipeBoardVO = recipeBoardService.getRecipeBoardsById(recipeBoardId);
		model.addAttribute("recipeBoardVO", recipeBoardVO);
	}

	@PostMapping("/modify")
	public String modifyPOST(RecipeBoardVO recipeBoardVO) {
		log.info("modifyPOST()");
		int result = recipeBoardService.updateRecipeBoard(recipeBoardVO);
		log.info(result + "�����");
		return "redirect:/board/list";
	}

	@PostMapping("/delete")
	public String delete(int recipeBoardId) {
		log.info("delete()");
		int result = recipeBoardService.deleteRecipeBoard(recipeBoardId);
		log.info(result + "�� ����");
		return "redirect:/board/list";
	}
}
