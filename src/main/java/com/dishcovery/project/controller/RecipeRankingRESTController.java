package com.dishcovery.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dishcovery.project.domain.RecipeBoardVO;
import com.dishcovery.project.domain.RecipeRankingVO;
import com.dishcovery.project.service.RecipeBoardService;
import com.dishcovery.project.service.RecipeRankingService;

import lombok.extern.log4j.Log4j;

@RequestMapping("/rankingboard")
@RestController
@Log4j
public class RecipeRankingRESTController {

    @Autowired
    private RecipeRankingService rankingService;

    @Autowired
    private RecipeBoardService recipeBoardService;

    /**
     * 특정 유형의 랭킹 데이터를 JSON 형식으로 반환
     * @param type 랭킹 유형 (DAILY, WEEKLY, MONTHLY)
     * @return JSON 데이터
     */
    @GetMapping("/rankings")
    public ResponseEntity<List<Map<String, Object>>> getRankings(@RequestParam(value = "type", required = false, defaultValue = "DAILY") String type) {
        log.info("Fetching rankings for type: " + type);

        // 1. RecipeRanking 데이터를 가져옴
        List<RecipeRankingVO> rankings = rankingService.getRankings(type.toUpperCase());

        // 2. RecipeBoard 데이터와 랭킹 데이터를 결합
        List<Map<String, Object>> result = rankings.stream().map(rank -> {
            RecipeBoardVO recipe = recipeBoardService.getByRecipeBoardId(rank.getRecipeBoardId());
            Map<String, Object> map = new HashMap<>();
            map.put("rankPosition", rank.getRankPosition());
            map.put("recipeBoardId", recipe.getRecipeBoardId());
            map.put("recipeBoardTitle", recipe.getRecipeBoardTitle());
            map.put("thumbnailPath", recipe.getThumbnailPath());
            map.put("recipeBoardViewCount", recipe.getViewCount());
            map.put("viewCount", rank.getViewCount()); // RecipeRanking 테이블의 ViewCount
            return map;
        }).collect(Collectors.toList());

        return ResponseEntity.ok(result);
    }
}
