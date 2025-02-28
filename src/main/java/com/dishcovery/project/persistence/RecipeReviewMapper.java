package com.dishcovery.project.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.dishcovery.project.domain.RecipeReviewVO;
import com.dishcovery.project.util.Pagination;

@Mapper
public interface RecipeReviewMapper {
	
	// 메서드 이름은 mapper xml에서 SQL 쿼리 정의 태그의 id와 동일
	// 매개변수는 mapper xml에서 #{변수명}과 동일(클래스 타입은 각 멤버변수명과 매칭)
	int insertRecipeReview(RecipeReviewVO recipeReviewVO); // 리뷰 등록
	List<RecipeReviewVO> selectListByRecipeBoardId(
			@Param("recipeBoardId")int recipeBoardId,
			@Param("pagination") Pagination pagination); // 전체 리뷰 조회
	int getTotalReviewCount(@Param("recipeBoardId") int recipeBoardId);
	int updateRecipeReview(RecipeReviewVO recipeReviewVO); // 특정 리뷰 수정
	int deleteRecipeReview(int RecipeReviewId); // 특정 리뷰 삭제
}
