package com.dishcovery.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.dishcovery.project.domain.IngredientsVO;
import com.dishcovery.project.domain.ProductVO;
import com.dishcovery.project.service.ProductService;
import com.dishcovery.project.util.PageMaker;
import com.dishcovery.project.util.Pagination;

@Controller
@RequestMapping("/store")
public class ProductController {

    @Autowired
    private ProductService productService;
    
    @GetMapping("/list")
    public String showProductList(@RequestParam(defaultValue = "1") int pageNum,
                                  @RequestParam(defaultValue = "4") int pageSize,
                                  Model model) {
        Pagination pagination = new Pagination(pageNum, pageSize);
        int totalCount = productService.getTotalProductCount();

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPagination(pagination);
        pageMaker.setTotalCount(totalCount);

        List<ProductVO> productList = productService.getAllProducts(pagination);

        model.addAttribute("productList", productList);
        model.addAttribute("pagination", pagination);
        model.addAttribute("pageMaker", pageMaker);

        return "store/list"; // 기존 방식 유지
    }
    
    @GetMapping("/register")
    public String showRegisterPage(Model model) {
        // ProductService에서 ingredients 목록 가져오기
        List<IngredientsVO> ingredientsList = productService.getAllProductIngredients();
        
        // JSP에서 사용할 모델에 추가
        model.addAttribute("ingredientsList", ingredientsList);

        return "store/register"; // register.jsp로 이동
    }
    
    @PostMapping("/register")
    public String registerProduct(@ModelAttribute ProductVO productVO, @RequestParam("productImage") MultipartFile file, Model model) {
        
        // 디버깅용 로그 출력
        System.out.println("등록 요청된 상품 정보: " + productVO);
        System.out.println("파일 업로드 요청: " + (file != null ? file.getOriginalFilename() : "파일 없음"));

        // 상품 등록 실행
        productService.insertProduct(productVO, file);
        return "redirect:/store/list";
    }
}
