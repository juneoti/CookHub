<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<!-- jquery 라이브러리 import -->
<base href="${pageContext.request.contextPath}/">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta charset="UTF-8">

<!-- css 파일 불러오기 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/image.css">
<!--  
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
-->
<title>${recipeBoard.recipeBoardTitle }</title>

<style>
.star-rating {
   display: inline-block;
   direction: rtl; /* 별을 오른쪽부터 채우도록 설정 */
   font-size: 20px; /* 별 크기 */
   color: lightgray;
}

.star-rating input[type="radio"] {
   display: none;
}

.star-rating label {
   cursor: pointer;
}

.star-rating label:before {
   content: '★';
   display: inline-block;
   transition: color 0.2s;
}

.star-rating input[type="radio"]:checked ~ label:before {
   color: gold;
}

.star-rating label:hover:before, .star-rating label:hover ~ label:before
   {
   color: gold;
}
  .hashtags {
    margin-top: 20px;
  }
  .hashtags span {
    display: inline-block;
    background-color: #f1f1f1;
    padding: 5px 10px;
    margin: 5px;
    border-radius: 15px;
    font-size: 14px;
    color: #333;
  }
  
</style>

</head>
<body>
   <h2>글 보기</h2>

   <div>
      <p>제목 :</p>
      <p>${recipeBoard.recipeBoardTitle }</p>
   </div>
   <div>
      <p>작성자 : ${recipeBoard.memberId }</p>
      <!-- boardDateCreated 데이터 포멧 변경 -->
      <fmt:formatDate value="${recipeBoard.recipeBoardCreatedDate }"
         pattern="yyyy-MM-dd HH:mm:ss" var="recipeBoardCreatedDate" />
      <p>작성일 : ${recipeBoardCreatedDate }</p>
   </div>
   <div>
      <textarea rows="20" cols="120" readonly>${recipeBoard.recipeBoardContent }</textarea>
   </div>

   <div>
      <p>타입 : ${typeName}</p>
   </div>
   <div>
      <p>방법 : ${methodName}</p>
   </div>
   <div>
      <p>상황 : ${situationName}</p>
   </div>
   <div>
      <p>재료 :</p>
      <ul>
         <c:forEach var="ingredient" items="${ingredients}">
            <li>${ingredient.ingredientName}</li>
         </c:forEach>
      </ul>
   </div>

    <!-- 해시태그 표시 -->
   <div class="hashtags">
      <h3>Hashtags:</h3>
      <c:forEach var="hashtag" items="${hashtags}">
         <span>#${hashtag.hashtagName}</span>
      </c:forEach>
   </div>
   
   <div>
      <p>첨부 이미지 :</p>
      <c:forEach var="attach" items="${attachList}">
         <img
            src="${pageContext.request.contextPath}${attach.recipeBoardPath}"
            alt="첨부 이미지" style="max-width: 300px;">
         <br>
      </c:forEach>
   </div>
   <button onclick="location.href='recipeboard/list'">글 목록</button>
   <button
      onclick="location.href='recipeboard/update/${recipeBoard.recipeBoardId}'">글
      수정</button>
   <button type="button" id="deleteBoard">글 삭제</button>
   <form id="deleteForm"
      action="recipeboard/delete/${recipeBoard.recipeBoardId}" method="POST">

      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

      <input type="hidden" name="recipeBoardId"
         value="${recipeBoard.recipeBoardId}">
   </form>

   <script type="text/javascript">
        $(document).ready(function(){
            $('#deleteBoard').click(function(){
                if(confirm('삭제하시겠습니까?')) {
                    $('#deleteForm').submit(); // form 데이터 전송
                }
            });
        }); // end document
    </script>


	<!-- isAnonymous(): 인증되지 않은(로그인하지 않은) 사용자만 접근을 허용 -->
   <input type="hidden" id="recipeBoardId"
      value="${recipeBoard.recipeBoardId }">

	<h2>댓글</h2>
	<sec:authorize access="isAnonymous()">
		*댓글을 작성하려면 로그인해 주세요.
	</sec:authorize>	

	<!-- isAuthenticated(): 인증된(로그인한) 사용자라면 누구나 접근을 허용 -->
	<sec:authorize access="isAuthenticated()">	
   <div style="text-align: left;">
      <input type="hidden" id="memberId" value="${user.username }"> 
      <input type="text" id="replyContent" maxlength="150">
      <button id="btnAdd">댓글 작성</button>
   </div>
	</sec:authorize>
		
   <hr> 
   <div style="text-align: left;">
      <div id="replies"></div>
   </div>

   <hr>
   
   	<h2>리뷰</h2>
   	<sec:authorize access="isAnonymous()">
		*리뷰를 작성하려면 로그인해 주세요.
	</sec:authorize>	
   
   <sec:authorize access="isAuthenticated()">	
   <div style="text-align: left;">
      <input type="hidden" id="reviewMemberId" value="${user.username }">
      <input type="text" id="recipeReviewContent">
      <span class="star-rating"> <input
         type="radio" name="reviewRating" id="star1" value="1"><label
         for="star1"></label> <input type="radio" name="reviewRating"
         id="star2" value="2"><label for="star2"></label> <input
         type="radio" name="reviewRating" id="star3" value="3"><label
         for="star3"></label> <input type="radio" name="reviewRating"
         id="star4" value="4"><label for="star4"></label> <input
         type="radio" name="reviewRating" id="star5" value="5"><label
         for="star5"></label>
      </span>
      
      <div class="image-upload">
		<div class="image-drop"></div>
	</div>

		<div class="reviewAttachDTOImg-list">
	</div>
	
	<div class="reviewAttachDTOFile-list">
	</div>
      
      <button id="btnReviewAdd">리뷰 작성</button>
      
      <script src="${pageContext.request.contextPath }/resources/js/image.js"></script>
   </div>
   </sec:authorize>
   
   <hr>
   <div style="text-align: left;">
      <div id="reviews"></div>
   </div>
  
   <script type="text/javascript">
   
//  $(document).ajaxSend(function(e, xhr, opt){
//		var token = $("meta[name='_csrf']").attr("content");
//		var header = $("meta[name='_csrf_header']").attr("content");
		
//		xhr.setRequestHeader(header, token);
//	});
	
	$(document).ready(function(){
    	  
                     getAllReply(); // reply 함수 호출
                     getAllRecipeReview(); // review 함수 호출
                             
                     $('#btnAdd').click(function() {
                        var recipeBoardId = $('#recipeBoardId').val(); // 게시판 번호 데이터
                        var memberId = $('#memberId').val(); // 작성자 데이터
                        var replyContent = $('#replyContent').val(); // 댓글 내용
                        // JS객체 생성
                        var obj = {
                           'recipeBoardId' : recipeBoardId, // 게시글 ID 전달
                           'memberId' : memberId,
                           'replyContent' : replyContent
                        }
                        // memberId 데이터 타입 문제일 수 있음

                        // $.ajax로 송수신
                        $.ajax({
                           type : 'POST', // 메서드 타입
                           url : '/project/recipeboard/replies/detail', // url
                           headers : {// 헤더 정보
                             'Content-Type' : 'application/json' // json content-type 설정 
                           },
                      	   data : JSON.stringify(obj), // JSON으로 변환 
                           success : function(result) { // 전송 성공 시 서버에서 result값 전송
                              console.log(result);
                              if (result == 1) {
                                 alert('댓글 입력 성공');
                                 getAllReply(); // 함수 호출
                              } else {
                                 alert('댓글 입력 실패');
                              }
                           },
                           error: function(xhr, status, error){ 
                        
                           console.error("AJAX 에러 발생:", status, error);
                           alert('댓글 입력 중 오류가 발생했습니다.');
                           }
                           
                        });
                     }); // end btn Add.click()
                     
                     $('#btnReviewAdd').click(function() {
                           var recipeBoardId = $('#recipeBoardId').val();
                           var memberId = $('#reviewMemberId').val();
                           var recipeReviewContent = $('#recipeReviewContent').val();

                           // 입력된 별점 값을 반전 (1 -> 5, 2 -> 4, ...)
                           var reviewRating = $("input[name='reviewRating']:checked").val();
                           reviewRating = 6 - parseInt(reviewRating, 10); // RTL에 따른 별점 값 반전

                           if (!reviewRating) {
                               alert('0점 이외의 별점을 입력하세요');
                               return;
                           }

                           var obj = {
                               'recipeBoardId': recipeBoardId,
                               'memberId': memberId,
                               'recipeReviewContent': recipeReviewContent,
                               'reviewRating': reviewRating
                               
                               
                           };
                           
                           var registerForm = $('#registerForm');
                           var i = 0;
                           $('.reviewAttachDTOImg-list input[name="reviewAttachDTO"]').each(function(){
                        	try{   
                        	   console.log(this); // JSON reviewAttachDTO 데이터를 object 변경
                           
                        	   var reviewAttachDTO = JSON.parse($(this).val());
                        	   var inputPath = $('<input>').attr('type', 'hidden')
                               .attr('name', 'attachList[' + i + '].attachPath');
                               inputPath.val(reviewAttachDTO.attachPath);
                           	   // attachRealName input 생성
                               var inputRealName = $('<input>').attr('type', 'hidden')
                                   .attr('name', 'attachList[' + i + '].attachRealName');
                               inputRealName.val(reviewAttachDTO.attachRealName);
                               // attachChgName input 생성
                               var inputChgName = $('<input>').attr('type', 'hidden')
                                   .attr('name', 'attachList[' + i + '].attachChgName');
                               
                               inputChgName.val(reviewAttachDTO.attachChgName);
                               
                               var inputExtension = $('<input>').attr('type', 'hidden')
                               .attr('name', 'attachList[' + i + '].attachExtension');
                               
                               inputExtension.val(reviewAttachDTO.attachExtension);
                               
                               // form에 태그 추가
                               registerForm.append(inputPath);
                               registerForm.append(inputRealName);
                               registerForm.append(inputChgName);
                               registerForm.append(inputExtension);

                               i++;
                        	} catch (e) {
                        		console.error("JSON 파싱 오류:", e);
                        	}
                        	
                           });
                  		   // FormData 객체 생성
                     	   var formData = new FormData(registerForm[0]);
                  		   
                     	  // 리뷰 데이터를 FormData에 추가
                     	    formData.append('recipeBoardId', recipeBoardId);
                     	    formData.append('memberId', memberId);
                     	    formData.append('recipeReviewContent', recipeReviewContent);
                     	    formData.append('reviewRating', reviewRating);
                     	    
                     	// 파일 데이터를 formData에 추가
                     	    var imageInput = document.getElementById('imageInput');
                     	    if (imageInput.files && imageInput.files.length > 0) {
                     	      for (var j = 0; j < imageInput.files.length; j++) {
                     	        formData.append('images', imageInput.files[j]);
                     	       }
                     	    }

                           console.log("전송 데이터:", obj);

                           $.ajax({
                               type: 'POST',
                               url: '/project/recipeboard/reviews/detail',
                    //         headers: { 'Content-Type': 'application/json' },

                               data: formData, //FormData 객체를 전송 
                               
                               contentType : false,
                               
                               processData : false,
                               
                               success: function(result) {
                                   console.log(result);
                                   if (result == 1) {
                                       alert('리뷰 입력 성공');
                          //           getAllRecipeReview();
                                   } else {
                                       alert('리뷰 입력 실패');
                                   }
                               },
                               error: function(xhr, status, error){
                                   console.error("AJAX 에러 발생:", status, error);
                                  alert('리뷰 입력 중 오류가 발생했습니다.');
                               }
                           });
                       });
                     
                  // 게시판 댓글 전체 가져오기
                     function getAllReply() {
                       var recipeBoardId = $('#recipeBoardId').val();
                       var url = '/project/recipeboard/all/' + recipeBoardId;

                       $.getJSON(url, function(data) {
                         console.log(data);

                         var list = '';

                         $(data).each(function() {
                           console.log(this);
                           var replyDateCreated = new Date(this.replyDateCreated);

                           list += '<div class="reply_item">' +
                                   '<pre>' +
                                     '<input type="hidden" id="replyId" value="' + this.replyId + '">' +
                                     this.memberId +
                                     '  ' +
                                      '<span class="replyContentDisplay" data-reply-id="' + this.replyId + '">' + this.replyContent + '</span>' +  // 텍스트로 출력, data 속성 추가
                                     '  ' +
                                     replyDateCreated +
                                     '  ' +
                                     '<button class="btn_update" data-reply-id="' + this.replyId + '">수정</button>' + // data 속성 추가
                                     '<button class="btn_delete" data-reply-id="' + this.replyId + '">삭제</button>' + // data 속성 추가
                                   '</pre>' +
                                  '</div>';
                         });

                         $('#replies').html(list);

                         // 수정 버튼 클릭 이벤트
                         $('#replies').on('click', '.btn_update', function() {
                           var replyId = $(this).data('reply-id'); // data 속성에서 replyId 가져오기
                           var replyContentSpan = $('.replyContentDisplay[data-reply-id="' + replyId + '"]'); // 수정할 span 요소 선택
                           var currentContent = replyContentSpan.text(); // 기존 텍스트 내용 가져오기

                        // span 요소를 text input으로 변경
                           replyContentSpan.replaceWith('<input type="text" class="replyContentInput" data-reply-id="' + replyId + '" value="' + currentContent + '">');


                           // 수정 완료 버튼 클릭 이벤트
                             $('#replies').on('click', '.btn_update_complete', function() {
                              
                               var replyId = $(this).data('reply-id');
                               var replyContentInput = $('.replyContentInput[data-reply-id="' + replyId + '"]');

                               var updatedReplyContent = replyContentInput.val();
                                 console.log("replyId : " + replyId + ", 수정할 내용 : " + updatedReplyContent);

                                  $.ajax({
                                       url: '/project/recipeboard/replies/' + replyId,
                                         type: 'PUT',
                                         dataType: "json",
                                         ContentType: 'application/json',
                                         data: JSON.stringify({
                                             replyId: replyId,
                                             replyContent: updatedReplyContent
                                         }),                                                          										 	
                                           success: function(result) {
                                             console.log(result);
                                             if (result == 1) {
                                                 alert('댓글 수정 성공!');
                                                getAllReply();
                                             }
                                           },
                                         error: function(xhr, status, error) {
                                          console.error("댓글 수정 실패 :", error);
                                         }
                                     });
                                 
                                });
                              
                              // 수정 완료 버튼으로 변경
                             $(this).replaceWith('<button class="btn_update_complete" data-reply-id="' + replyId + '">수정 완료</button>');

                         });
                       });
                     }   

                     // 삭제 버튼을 클릭하면 선택된 댓글 삭제
                     $('#replies')
                           .on(
                                 'click',
                                 '.reply_item .btn_delete',
                                 function() {
                                    console.log(this);
                                    var recipeBoardId = $(
                                          "#recipeBoardId").val(); // 게시판 번호 데이터
                                    var replyId = $(this).prevAll(
                                          '#replyId').val(); // 댓글 번호 데이터

                                    $
                                          .ajax({
                                             type : 'DELETE',
                                             dataType: "json",
                                             url : '/project/recipeboard/replies/'
                                                   + replyId
                                                   + '/'
                                                   + recipeBoardId,
                                             headers : {
                                                'Content-Type' : 'application/json'
                                             },
                                             success : function(
                                                   result) {
                                                console
                                                      .log(result);
                                                if (result == 1) {
                                                   alert('댓글 삭제 성공!');
                                                   getAllReply();
                                                }
                                             }
                                          });
                                 }); // end replies.on
                                 
                                 // 리뷰 전체 불러오기
                                 function getAllRecipeReview() {
                                    var recipeBoardId = $('#recipeBoardId').val();
                                    var url = '/project/recipeboard/allReviews/'
                                             + recipeBoardId;
                                    $
                                          .getJSON(
                                             url,
                                             function(data) {
                                                console.log("리뷰 데이터:", data);
                                                var list = '';
                                                $(data)
                                                   .each(
                                                   function() {
                                                      console.log("별점 값:", this.reviewRating);
                                                      recipeReviewDateCreated = new Date(this.recipeReviewDateCreated)
                                                      
                                                      var starRatingHTML = '';
                                                      for (let i = 1; i <= 5; i++) {
                                                          if (i <= this.reviewRating) {
                                                              starRatingHTML += '<span style="color:gold;">★</span>'; // 채워진 별
                                                          } else {
                                                              starRatingHTML += '<span style="color:lightgray;">★</span>'; // 빈 별
                                                          }
                                                      }
                                                      
                                                      list += '<div class="review_item">'
                                                      + '<pre>'
                                                      + '<input type="hidden" id="recipeReviewId" value="' + this.recipeReviewId + '">'
                                                      + this.memberId
                                                      + '&nbsp;&nbsp;'
                                                      + '<input type="text" id="recipeReviewContent" value="' + this.recipeReviewContent + '">'
                                                      + '&nbsp;&nbsp;'
                                                      + '<br>'
                                                      + '<span style="font-size: 1.2em;">' + starRatingHTML + '</span>' // 별점 추가
                                                      + '&nbsp;&nbsp;'
                                                      + recipeReviewDateCreated
                                                      + '&nbsp;&nbsp;'
                                                      + '<button class="btn_review_update" >수정</button>'
                                                      + '<button class="btn_review_delete" >삭제</button>'
                                                      + '</pre>'
                                                      + '</div>';
                                                      
                                                   });
                                                $('#reviews').html(list);
                                             });
                                   
                                    
                                     
                                 }      
                                
                                 // 수정 버튼을 클릭하면 선택된 댓글 수정
                                 $('#reviews')
                                       .on(
                                             'click',
                                             '.review_item .btn_review_update',
                                             function() {
                                                console.log(this);

                                                // 선택된 리뷰의 replyId, replyContent 값을 저장
                                                // prevAll() : 선택된 노드 이전에 있는 모든 형제 노드를 접근
                                                var recipeReviewId = $(this).prevAll(
                                                      '#recipeReivewId').val();
                                                var recipeReviewContent = $(this)
                                                      .prevAll(
                                                            '#recipeReviewContent')
                                                      .val();
                                                console.log("선택된 리뷰 번호 : "
                                                      + recipeReviewId
                                                      + ", 댓글 내용 : "
                                                      + recipeReviewContent
                                                     + ", 리뷰 별점 : "
                                                     + reviewRating);

                                                // ajax 요청
                                                $
                                                      .ajax({
                                                         type : 'PUT',
                                                         dataType: "json",
                                                         url : '/project/recipeboard/reviews/'
                                                               + recipeReviewId,
                                                         headers : {
                                                            'Content-Type' : 'application/json'
                                                         },
                                                         data : JSON.stringify(obj),
                                                         success : function(
                                                               result) {
                                                            console
                                                                  .log(result);
                                                            if (result == 1) {
                                                               alert('리뷰 수정 성공!');
                                                               getAllRecipeReview();
                                                            }
                                                         }
                                                      });

                                             }); // end review.on()   
                                 
                              // 삭제 버튼을 클릭하면 선택된 리뷰 삭제
                                 $('#reviews')
                                       .on(
                                             'click',
                                             '.review_item .btn_review_delete',
                                             function() {
                                                console.log(this);
                                                var recipeBoardId = $(
                                                      "#recipeBoardId").val(); // 게시판 번호 데이터
                                                var recipeReviewId = $(this).prevAll(
                                                      '#recipeReviewId').val(); // 댓글 번호 데이터

                                                $
                                                      .ajax({
                                                         type : 'DELETE',
                                                         dataType: "json",
                                                         url : '/project/recipeboard/reviews/'
                                                               + recipeReviewId
                                                               + '/'
                                                               + recipeBoardId,
                                                         headers : {
                                                            'content-Type' : 'application/json'
                                                         },
                                                         success : function(
                                                               result) {
                                                            console
                                                                  .log(result);
                                                            if (result == 1) {
                                                               alert('리뷰 삭제 성공!');
                                                               getAllRecipeReview();
                                                            }
                                                         }
                                                      });
                                             }); // end reviews.on
                            
                  }); // end document()
                  
                                   
   </script>
</body>
</html>
