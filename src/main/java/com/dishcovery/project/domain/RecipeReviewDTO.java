package com.dishcovery.project.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class RecipeReviewDTO {
	private int recipeReviewId;
	private int recipeBoardId;
	private int memberId;
	private String recipeReviewContent;
	private int reviewRating;
	private Date recipeReviewDateCreated;
	private String imagePath;
	
	private List<ReviewAttachDTO> ReviewAttachList;
	
	public List<ReviewAttachDTO> getReviewAttachList(){
		if(ReviewAttachList == null) {
			ReviewAttachList = new ArrayList<ReviewAttachDTO>();
		}
		return ReviewAttachList;
	}
}