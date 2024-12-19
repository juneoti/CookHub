package com.dishcovery.project.domain;

import java.util.Date;
import java.util.List;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RecipeBoardVO {
	private int recipeBoardId;				//보드 아이디
    private String recipeBoardTitle;		//제목
    private String recipeBoardContent;		//내용
    private int memberId;					//등록자 아이디
    private Date recipeBoardCreatedDate;	//등록 시간
    private int viewCount;					//리뷰 갯수
    private int typeId;						//타입
    private int methodId;					//방법
    private int situationId;				//상황
    private double avgRating;				//별점
    private int replyCount;					//댯글 갯수
    private int recipeReviewCount;       	//댓글	
    private List<IngredientsVO> ingredientList;  // 여러 개의 재료
    private List<SituationsVO> situationList;    // 여러 개의 상황
    private List<MethodsVO> methodList;          // 여러 개의 방법
    private List<TypesVO> typeList;              // 여러 개의 타입
    
    private String ingredientListStr; // 재료 리스트 문자열
    private String methodListStr;     // 방법 리스트 문자열
    private String situationListStr;  // 상황 리스트 문자열
    private String typeListStr;       // 타입 리스트 문자열
}