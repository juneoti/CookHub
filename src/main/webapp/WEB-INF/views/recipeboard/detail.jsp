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


            // 댓글 수정 기능
            function updateReply(replyId, contentDiv) {
                // 현재 댓글 내용을 가져옴
                const currentContent = contentDiv.text();

                // 수정할 텍스트 입력 필드 생성
                const editInput = $('<textarea style="width: 100%; padding: 5px; margin-bottom: 5px;"></textarea>').val(currentContent);

                contentDiv.replaceWith(editInput);
                 editInput.focus();


                  // 수정완료 버튼 생성
                const saveButton = $('<button style="margin-right: 5px;">수정 완료</button>').click(function() {
					    const updatedContent = editInput.val();
					    $.ajax({
					        url: 'reply/update',
					        type: 'POST',
					        data: {
					            replyId: replyId,
					            replyContent: updatedContent
					        },
					        success: function() {
					        	 loadReplies();
					        },
					        error: function(error) {
					            console.error("댓글 수정 에러:", error);
					             alert('댓글을 수정하는 도중 오류가 발생했습니다.');
					        }
					    });
					});

                // 수정 취소 버튼 생성
                const cancelButton = $('<button>취소</button>').click(function() {
                     loadReplies();
                });
               editInput.parent().find('.reply-actions').empty().append(saveButton).append(cancelButton);
            }

            // 댓글 삭제 기능
            function deleteReply(replyId) {
                if (confirm('댓글을 삭제하시겠습니까?')) {
                    $.ajax({
                        url: 'reply/delete',
                        type: 'POST',
                        data: { replyId: replyId },
                        success: function() {
                             loadReplies(); // 댓글 목록 새로고침
                        },
                        error: function(error) {
                            console.error("댓글 삭제 에러:", error);
                            alert('댓글을 삭제하는 도중 오류가 발생했습니다.');
                        }
                    });
                }
            }

        });
    </script>
</body>
</html>