<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 게시판 목록</title>
</head>
<body>
	<h2>레시피 게시판 목록</h2>
    <hr>
    <button type="button" onclick="location.href='register'">레시피등록</button>
	<table border="1">
		<thead>
			<tr>
				<th style="width: 700px">제목</th>
				<th style="width: 120px">작성자</th>
				<th style="width: 100px">작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="RecipeBoardVO" items="${recipeBoardList}">
				<tr>
					<td><a href="detail?recipeBoardId=${RecipeBoardVO.recipeBoardId}">${RecipeBoardVO.recipeBoardTitle}</a></td>
					<td>${RecipeBoardVO.memberId}</td>
					<!-- boardDateCreated 데이터 포멧 변경 -->
					<fmt:formatDate value="${RecipeBoardVO.recipeBoardCreatedDate}"
						pattern="yyyy-MM-dd HH:mm:ss" var="formattedDate" />
					<td>${recipeBoardCreatedDate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
    
	<ul>
		<!-- 이전 버튼 생성을 위한 조건문 -->
		<c:if test="${pageMaker.isPrev()}">
			<li><a href="list?pageNum=${pageMaker.startNum - 1}">이전</a></li>
		</c:if>
		<!-- 반복문으로 시작 번호부터 끝 번호까지 생성 -->
		<c:forEach begin="${pageMaker.startNum}" end="${pageMaker.endNum}" var="num">
			<li><a href="list?pageNum=${num}">${num}</a></li>
		</c:forEach>
		<!-- 다음 버튼 생성을 위한 조건문 -->
		<c:if test="${pageMaker.isNext()}">
			<li><a href="list?pageNum=${pageMaker.endNum + 1}">다음</a></li>
		</c:if>
	</ul>
</body>
</html>