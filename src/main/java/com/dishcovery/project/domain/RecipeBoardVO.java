package com.dishcovery.project.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.NoArgsConstructor;

import java.util.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class RecipeBoardVO {

	private int recipeBoardId;
	String recipeBoardTitle;
	String recipeBoardContent;
	String memberId;
	Date recipeBoardCreatedDate;
	int viewCount;
	int typeId;
	int methodId;
	int situationId;
	int ingredientId;
	double avgRating;
	int replyCount;
	int recipeReviewCount;
	String thumbnailPath;
	String recipeTip;
	String servings;
	String time;
	String difficulty;
}
