<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<!-- jquery 라이브러리 import -->
<base href="${pageContext.request.contextPath}/">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<meta charset="UTF-8">
<title>${recipeBoard.recipeBoardTitle }</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
    rel="stylesheet">

<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	margin: 0;
	padding: 20px;
	background-color: #f8f9fa;
}

.detail-container {
	max-width: 800px;
	margin: 0 auto;
	padding: 30px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.detail-container > div {
    margin-bottom: 20px;
}

.detail-container .section-title {
    font-size: 1.3rem;
    margin-bottom: 15px;
    color: #343a40;
    border-bottom: 1px solid #dee2e6;
    padding-bottom: 5px;
}

.detail-container .info-item {
    margin-bottom: 5px;
    color: #495057;
    display: flex;
    align-items: center;
}

.detail-container .info-item .label {
    font-weight: bold;
    margin-right: 5px;
    min-width: 60px;
}

.detail-container textarea {
    width: 100%;
    padding: 10px;
    border: 1px solid #ced4da;
    border-radius: 4px;
    font-size: 1rem;
    box-sizing: border-box;
    margin-top: 5px;
    resize: vertical;
    font-family: 'Noto Sans KR', sans-serif;
    color: #495057;
    outline: none;
}

.detail-container ul {
	list-style: none;
	padding: 0;
}

.detail-container li {
	margin-bottom: 5px;
	color: #495057;
}

.detail-container img {
	max-width: 100%;
	max-height: 300px;
	display: block;
	margin: 10px auto;
}

.star-rating {
	display: inline-block;
	direction: rtl;
	font-size: 20px;
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

.step-row {
	margin-bottom: 20px;
	border: 1px solid #dee2e6;
	padding: 15px;
	border-radius: 8px;
}

.step-row .step-label {
	font-weight: bold;
	margin-bottom: 10px;
	font-size: 1.1rem;
	display: block;
}

.step-row textarea {
	width: 100%;
	padding: 10px;
	border: 1px solid #ced4da;
	border-radius: 4px;
	margin-bottom: 10px;
	font-size: 1rem;
	resize: vertical;
	font-family: 'Noto Sans KR', sans-serif;
	color: #495057;
	outline: none;
}

.step-row img {
	max-width: 100%;
	max-height: 100px;
	display: block;
	margin: 10px auto;
}
 .ingredient-detail-row {
    margin-bottom: 10px;
    padding: 10px;
    border: 1px solid #dee2e6;
    border-radius: 4px;
}
.ingredient-detail-row .label {
    font-weight: bold;
    margin-right: 5px;
}
.ingredient-detail-row span {
    color: #495057;
}
/* 댓글 관련 스타일 */
.reply-container {
    border: 1px solid #ddd;
    padding: 10px;
    margin-bottom: 10px;
    background-color: #f9f9f9;
    border-radius: 5px;
    display: flex;
    flex-direction: column;
}
.reply-container .reply-header {
    display: flex;
    justify-content: space-between;
    margin-bottom: 5px;
}
.reply-container .reply-header .member-id {
    font-weight: bold;
}
.reply-container .reply-header .created-date {
    font-size: 0.8em;
    color: #888;
}
.reply-container .reply-content {
    padding: 5px 0;
    color: #333;
}
.reply-container .reply-actions {
	display: flex;
	justify-content: flex-end;
	margin-top: 5px;
}
.reply-container .reply-actions button {
	margin-left: 5px;
	padding: 5px 10px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 0.9em;
}
.reply-container .reply-actions button:hover {
	background-color: #0056b3;
}

.reply-form {
	margin-top: 20px;
	text-align: center;
}
.reply-form input[type="text"] {
    padding: 8px;
    margin-right: 5px;
    border: 1px solid #ced4da;
    border-radius: 4px;
}
.reply-form button {
    padding: 8px 12px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}
.reply-form button:hover {
	background-color: #0056b3;
}
/* 카테고리 및 요리 정보 컨테이너 */
.info-container {
  display: flex;
  flex-wrap: wrap;
  margin-bottom: 20px;
  border: 1px solid #dee2e6;
  padding: 15px;
  border-radius: 8px;
  background-color: #f9f9f9;
}

.info-container .category-section,
.info-container .recipe-info-section {
  width: 48%; /* 좌우로 나뉘도록 */
    margin-bottom: 15px;
  box-sizing: border-box; /* 패딩, 테두리 포함 너비 */
   padding: 10px;
}

.info-container .category-section:last-child,
.info-container .recipe-info-section:last-child{
   margin-right: 0;
}
@media (max-width: 768px) {
    .info-container .category-section,
    .info-container .recipe-info-section {
         width: 100%;
    }
}
</style>

</head>
<body>
	<div class="detail-container">
		<h2 class="section-title">글 보기</h2>

		<div>
			<h3 class="section-title">
				제목
			</h3>
			<p>${recipeBoard.recipeBoardTitle }</p>
		</div>

		<div>
             <h3 class="section-title">작성자 정보</h3>
           <div class="info-item">
            	<span class="label">작성자 :</span>
                <span>${recipeBoard.memberId }</span>
           </div>
			<!-- boardDateCreated 데이터 포멧 변경 -->
			<fmt:formatDate value="${recipeBoard.recipeBoardCreatedDate }"
				pattern="yyyy-MM-dd HH:mm:ss" var="recipeBoardCreatedDate" />
            <div class="info-item">
                 <span class="label">작성일 :</span>
                <span>${recipeBoardCreatedDate }</span>
           </div>
		</div>

		<div>
             <h3 class="section-title">썸네일 이미지</h3>
			<c:if test="${recipeBoard.thumbnailPath != null}">
				<!-- 썸네일 이미지 경로를 사용해 이미지를 표시 -->
				<img
					src="${pageContext.request.contextPath}/uploads/${recipeBoard.thumbnailPath}"
					alt="썸네일 이미지">
			</c:if>
			<c:if test="${recipeBoard.thumbnailPath == null}">
				<p>썸네일 이미지가 없습니다.</p>
			</c:if>
		</div>

		<div>
            <h3 class="section-title">내용</h3>
            <textarea rows="10" readonly>${recipeBoard.recipeBoardContent }</textarea>
        </div>
		<div>
            <h3 class="section-title">요리 팁</h3>
            <textarea rows="5" readonly>${recipeBoard.recipeTip }</textarea>
        </div>

		<!-- 카테고리 및 요리 정보 표시 -->
		<div class="info-container">
			<div class="category-section">
				<h3 class="section-title">카테고리</h3>
                <div class="info-item">
                    <span class="label">종류:</span>
                   <span>${typeName}</span>
               </div>
                <div class="info-item">
                    <span class="label">방법:</span>
                    <span>${methodName}</span>
               </div>
               <div class="info-item">
                   <span class="label">상황:</span>
                    <span>${situationName}</span>
               </div>
                <div class="info-item">
                    <span class="label">재료:</span>
                     <ul>
				        <c:forEach var="ingredient" items="${ingredients}">
					       <li>${ingredient.ingredientName}</li>
				        </c:forEach>
			         </ul>
                </div>
			</div>
			<div class="recipe-info-section">
				<h3 class="section-title">요리 정보</h3>
                <div class="info-item">
                   <span class="label">인분:</span>
                   <span>${recipeBoard.servings}</span>
                </div>
                 <div class="info-item">
                    <span class="label">시간:</span>
                     <span>${recipeBoard.time}</span>
                 </div>
                  <div class="info-item">
                    <span class="label">난이도:</span>
                    <span>${recipeBoard.difficulty}</span>
                  </div>
			</div>
		</div>


          <div>
              <h3 class="section-title">재료 상세 정보</h3>
            <c:forEach var="ingredientDetail" items="${ingredientDetails}">
              <div class="ingredient-detail-row">
               <span class="label">이름:</span> <span>${ingredientDetail.ingredientName}</span>
                <span class="label">수량:</span> <span>${ingredientDetail.ingredientAmount}</span>
                <span class="label">단위:</span> <span>${ingredientDetail.ingredientUnit}</span>
                <c:if test="${not empty ingredientDetail.ingredientNote}">
                 <span class="label">비고:</span> <span>${ingredientDetail.ingredientNote}</span>
                </c:if>
              </div>
             </c:forEach>
          </div>

		<!-- 해시태그 표시 -->
		<div class="hashtags">
			<h3 class="section-title">해시태그</h3>
			<c:forEach var="hashtag" items="${hashtags}">
				<span>#${hashtag.hashtagName}</span>
			</c:forEach>
		</div>

		<!-- 요리 단계 표시 -->
		<div>
			<h3 class="section-title">요리 순서</h3>
			<c:forEach var="step" items="${steps}" varStatus="status">
				<div class="step-row">
					<label class="step-label">Step ${status.index + 1}</label>
					<textarea rows="3" readonly>${step.stepDescription}</textarea>
					<c:if test="${step.stepImageUrl != null}">
						<img
							src="${pageContext.request.contextPath}/uploads/${step.stepImageUrl}"
							alt="요리 단계 이미지" />
					</c:if>
				</div>
			</c:forEach>
		</div>

		<div>
			<button onclick="location.href='recipeboard/list'">글 목록</button>
			<button
				onclick="location.href='recipeboard/update/${recipeBoard.recipeBoardId}'">글
				수정</button>
			<button type="button" id="deleteBoard">글 삭제</button>
			<form id="deleteForm"
				action="recipeboard/delete/${recipeBoard.recipeBoardId}"
				method="POST">
				<input type="hidden" name="recipeBoardId"
					value="${recipeBoard.recipeBoardId}">
			</form>
		</div>

        <!-- 댓글 입력 폼 -->
		<div class="reply-form">
			<input type="text" id="memberId" placeholder="사용자 ID">
			<input type="text" id="replyContent" placeholder="댓글 내용을 입력하세요">
			<button id="btnAdd">댓글 작성</button>
		</div>

		<hr>

		<!-- 댓글 목록 -->
		<div id="replies"></div>


	</div>

    <script type="text/javascript">
        $(document).ready(function() {
            // 삭제 버튼 클릭 이벤트 처리
            $('#deleteBoard').click(function() {
                if (confirm('삭제하시겠습니까?')) {
                    $('#deleteForm').submit();
                }
            });

            const recipeBoardId = $("#recipeBoardId").val();
            // 댓글 목록 로드 함수
            function loadReplies() {
            	$.ajax({
                    url: 'reply/list',
                    type: 'GET',
                    data: { recipeBoardId: recipeBoardId }, // boardId를 서버에 전달
                    dataType: 'json',
                    success: function(data) {
                        $('#replies').empty(); // 기존 댓글 비우기
                        if (data.length > 0) {
                            data.forEach(function(reply) {
                                // 댓글 요소를 생성
                                const replyElement = $('<div class="reply-container"></div>');
                                const replyHeader = $('<div class="reply-header"></div>');
                                const memberIdSpan = $('<span class="member-id"></span>').text(reply.memberId);
                                const createdDateSpan = $('<span class="created-date"></span>').text(new Date(reply.replyCreatedDate).toLocaleString()); // 날짜 포맷 변경
                                replyHeader.append(memberIdSpan).append(createdDateSpan);

                                const replyContentDiv = $('<div class="reply-content"></div>').text(reply.replyContent);

                                //댓글 수정/삭제 버튼
                                const replyActionsDiv = $('<div class="reply-actions"></div>');
                                const updateButton = $('<button class="update-reply">수정</button>').click(function() {
                                    updateReply(reply.replyId, replyContentDiv); //수정버튼 클릭시 수정기능 함수 호출
                                });
                                const deleteButton = $('<button class="delete-reply">삭제</button>').click(function() {
                                    deleteReply(reply.replyId); //삭제버튼 클릭시 삭제 기능 함수 호출
                                });
                                replyActionsDiv.append(updateButton).append(deleteButton);

                                replyElement.append(replyHeader).append(replyContentDiv).append(replyActionsDiv);
                                $('#replies').append(replyElement);
                            });
                        } else {
                            $('#replies').text('댓글이 없습니다.');
                        }
                    },
                    error: function(error) {
                        console.error("댓글 로드 에러:", error);
                        $('#replies').text('댓글을 불러오는 중 오류가 발생했습니다.');
                    }
                });
            }

            loadReplies(); // 페이지 로드 시 댓글 로드

            // 댓글 작성 기능
            $("#btnAdd").click(function() {
                const memberId = $("#memberId").val();
                const replyContent = $("#replyContent").val();
				if (!memberId || memberId.trim() === "") {
				    alert("사용자 ID를 입력하세요.");
				    return;
				}
                if (!replyContent || replyContent.trim() === "") {
                    alert("댓글 내용을 입력하세요.");
                    return;
                }
                $.ajax({
                    url: 'reply/add',
                    type: 'POST',
                    data: {
                        recipeBoardId: recipeBoardId, // 해당 게시글의 ID
                        memberId: memberId,
                        replyContent: replyContent
                    },
                    success: function() {
                        $("#memberId").val("");
                         $("#replyContent").val("");// 댓글 작성 후 입력 필드 초기화
                        loadReplies(); // 댓글 목록 새로고침
                    },
                    error: function(error) {
                       console.error("댓글 작성 에러:", error);
                       alert('댓글을 작성하는 도중 오류가 발생했습니다.');
                    }
                });
            });
	
   <input type="hidden" id="recipeBoardId"
      value="${recipeBoard.recipeBoardId }">

	<h2>댓글</h2>
<sec:authorize access="isAuthenticated()">	
   <div style="text-align: left;">
      <sec:authentication var="customUser" property="principal" />
      <c:set var="loggedInMemberId" value="${customUser.memberVO.memberId}" />   
   </div>
</sec:authorize>	

<div style="text-align: left;">
      <!-- memberId를 입력하는 대신 span 태그로 표시 -->
      <span id="loggedInMemberId">${loggedInMemberId}</span>
      <!-- hidden 필드로 memberId 전송 -->
      <input type="hidden" id="memberId" value="${loggedInMemberId}">
      
      <input type="text" id="replyContent" maxlength="150" placeholder="댓글을 입력하세요">
<button id="btnAdd">댓글 작성</button>
</div>
		
   <hr> 
      <div id="replies"></div>
   <hr>
   
   	<h2>리뷰</h2>	
   
  
   <div style="text-align: left;">
   		<span id="loggedInReviewMemberId">${loggedInMemberId}</span>
        <input type="hidden" id="reviewMemberId" value="${loggedInMemberId}">
   <input type="text" id="recipeReviewContent" placeholder="리뷰 내용을 입력하세요">     
      
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
      
      <button id="btnReviewAdd">리뷰 작성</button>
    </div>
      
       <hr>
   	   <div id="reviews"></div>
      
      <div class="image-upload">
  
		<div class="image-drop">drag - image</div>
	  </div>

		<div class="reviewAttachDTOImg-list">
	  </div>
 
      <button id="btnReviewAdd">리뷰 작성</button>
      
      <script src="${pageContext.request.contextPath }/resources/js/image.js"></script>

   
   <hr>
   <div style="text-align: left;">
      <div id="reviews"></div>
   </div>
  
   <script type="text/javascript">
   
      $(document)
            .ready(
                  function() {
                	 var contextRoot = '/project';
                     // CSRF 토큰 설정
                     var csrfToken = $('meta[name="_csrf"]').attr('content');
                     var csrfHeader = $('meta[name="_csrf_header"]').attr('content');
                     
                	 getAllReply(); // reply 함수 호출
                     getAllRecipeReview(); // review 함수 호출
                  	 
                     // AJAX 전역 설정: 모든 요청에 CSRF 토큰 추가
                     $.ajaxSetup({
                         beforeSend: function (xhr) {
                             xhr.setRequestHeader(csrfHeader, csrfToken); // CSRF 토큰을 헤더에 추가
                         }
                     });
                     
                     var isLoggedIn = false;
                     
                	 // 좋아요 초기 상태 가져오기
                     function loadLikeStatus() {
                         var recipeBoardId = $('#recipeBoardId').val(); // 게시글 ID
                         $.get(contextRoot + '/recipeboard/' + recipeBoardId + '/like-count', function (response) {
                             $('#like-count').text(response.likeCount); // 좋아요 개수 업데이트
                         });
                         
                      // 로그인한 사용자의 좋아요 여부 확인
                         $.get(contextRoot + '/recipeboard/' + recipeBoardId + '/like-status', function(response) {
                            isLoggedIn = true; // 로그인 확인
                            if (response.liked) {
                               $('#like-button').text('좋아요 취소');
                            } else {
                               $('#like-button').text('좋아요');
                            }
                         }).fail(function(xhr) {
                        	if (xhr.status === 403) {
                        	    console.warn('로그인이 필요합니다.'); // 경고만 출력, 네트워크 에러 발생 안함
                        	    isLoggedIn = false;
                        	    $('#like-button').text('로그인 후 사용 가능');
                        	}
                         });
                     }

                     // 좋아요 버튼 클릭 이벤트
                     $('#like-button').click(function () {
				    var recipeBoardId = $('#recipeBoardId').val(); // 게시글 ID
				    $.ajax({
				        type: 'POST',
				        url: contextRoot + '/recipeboard/' + recipeBoardId + '/like', // 좋아요 토글 API
				        success: function (response) {
				            if (response.message === "로그인이 필요한 서비스입니다.") {
				                alert(response.message); // 로그인 필요 메시지 표시
				            } else {
				                if (response.liked) {
				                    $('#like-button').text('좋아요 취소'); // 버튼 텍스트 변경
				                    alert('좋아요가 설정되었습니다.');
				                } else {
				                    $('#like-button').text('좋아요'); // 버튼 텍스트 변경
				                    alert('좋아요가 취소되었습니다.');
				                }
				            }
				            $('#like-count').text(response.likeCount); // 좋아요 개수 업데이트
				        }
				    });
				});
                     
                     loadLikeStatus();                                        
                          
                     $('#btnAdd').click(function() {
                        var recipeBoardId = $('#recipeBoardId').val(); // 게시판 번호 데이터
                      	var memberId = $('#memberId').val();
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
                           
                           // hidden input에서 reviewAttachDTO 값 가져오기
                           var reviewAttachDTOs = [];
                           $("input[type='hidden'][name='reviewAttachDTO']").each(function() {
                               var attachData = JSON.parse($(this).val()); // JSON 파싱
                               reviewAttachDTOs.push(attachData);
                           });
                           
                           var obj = {
                               'recipeBoardId': recipeBoardId,
                               'memberId': memberId,
                               'recipeReviewContent': recipeReviewContent,
                               'reviewRating': reviewRating
                            
                           };
                           
                           if (reviewAttachDTOs.length > 0) {
                        	    obj.reviewAttachList = reviewAttachDTOs;
                        	} else {
                        	    obj.reviewAttachList = [];
                        	}
                           
                           
                           console.log("전송 데이터:", obj);

                           $.ajax({
                               type: 'POST',
                               url: '/project/recipeboard/reviews/detail',
                               headers: { 'Content-Type': 'application/json' },
                               data: JSON.stringify(obj),
                               success: function(result) {
                                   console.log(result);
                                   if (result == 1) {
                                       alert('리뷰 입력 성공');
                                       getAllRecipeReview();
                                       
                                   } else {
                                       alert('리뷰 입력 실패');
                                   }
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
                                                  
                           // 수정 완료 버튼으로 변경
                           $(this).replaceWith('<button class="btn_update_complete" data-reply-id="' + replyId + '">수정 완료</button>');

                           
                           // 수정 완료 버튼 클릭 이벤트
                             $('#replies').off('click', '.btn_update_complete').on('click', '.btn_update_complete', function() {
                              
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
                                                      
                                                      // 이미지 표시 HTML 생성
                                                      var imageHTML = '';
                                                      if (this.reviewAttachList && this.reviewAttachList.length > 0) {
                                                          this.reviewAttachList.forEach(function(reviewAttach) {
                                                              var imageUrl = "/project/image/display?attachPath=" + encodeURIComponent(reviewAttach.attachPath) + 
                                                                             "&attachChgName=" + encodeURIComponent(reviewAttach.attachChgName) + 
                                                                             "&attachExtension=" + encodeURIComponent(reviewAttach.attachExtension);
                                                              
                                                              imageHTML += '<div class="image_item" data-chgName="'+ reviewAttach.attachChgName +'">'
                                                                        + '<a href="' + imageUrl + '" target="_blank">'
                                                                        + '<img width="100px" height="100px" src="' + imageUrl + '" />'
                                                                        + '</a>'                                                                       
                                                                        + '</div>';
                                                          });
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
                                          //          + '<button class="btn_review_update" >수정</button>'
                                                      + '<button class="btn_review_delete" >삭제</button>'
                                                                                                      
                                                      // 이미지가 있는 경우만 추가
                                                      if (imageHTML !== '') {
                                                          list += '<div class="review_images image-list">' + imageHTML + '</div>';
                                                      }

                                                      list += '</pre>'
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
                                                      '#recipeReviewId').val();
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
                                                            'Content-Type' : 'application/json'
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