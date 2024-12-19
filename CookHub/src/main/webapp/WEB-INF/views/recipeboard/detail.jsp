<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<!-- jquery 라이브러리 import -->
<script src="https://code.jquery.com/jquery-3.7.1.js">
	
</script>
<meta charset="UTF-8">
<title>${recipeBoard.recipeBoardTitle }</title>
</head>
<body>
  <c:if test="${recipeBoard != null}">
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
		<p>재료:</p>
	   <c:if test="${recipeBoard.ingredientList}">
		<c:forEach items="${recipeBoard.ingredientList}" var="ingredient">
			<p>- ${ingredient.ingredientName}</p>
		</c:forEach>
    </c:if>
	</div>
	<div>
		<p>방법:</p>
     <c:if test="${recipeBoard.methodList}">
		<c:forEach items="${recipeBoard.methodList}" var="method">
			<p>- ${method.methodName}</p>
		</c:forEach>
       </c:if>
	</div>
	<div>
		<p>상황:</p>
	  <c:if test="${recipeBoard.situationList}">
		<c:forEach items="${recipeBoard.situationList}" var="situation">
			<p>- ${situation.situationName}</p>
		</c:forEach>
        </c:if>
	</div>
	<div>
		<p>타입:</p>
     <c:if test="${recipeBoard.typeList}">
		<c:forEach items="${recipeBoard.typeList}" var="type">
			<p>- ${type.typeName}</p>
		</c:forEach>
       </c:if>
	</div>
	<button onclick="location.href='list'">글 목록</button>
	<button
		onclick="location.href='modify?recipeBoardId=${recipeBoard.recipeBoardId}'">글수정</button>
	<button id="deleteBoard">글 삭제</button>
	<form id="deleteForm" action="delete" method="POST">
		<input type="hidden" name="recipeBoardId"
			value="${recipeBoard.recipeBoardId }">
	</form>

	<script type="text/javascript">
		$(document).ready(function() {
			$('#deleteBoard').click(function() {
				if (confirm('삭제하시겠습니까?')) {
					$('#deleteForm').submit(); // form 데이터 전송
				}
			});
		}); // end document
	</script>
    </c:if>
    <c:if test="${recipeBoard == null}">
          <p>해당 게시글이 존재하지 않습니다.</p>
        <a href="/recipeboard/list">목록으로 돌아가기</a>
     </c:if>
</body>
</html>