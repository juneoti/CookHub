<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 등록 페이지</title>
</head>
<body>
    <h1>레시피 등록</h1>
    <form action="register" method="post">
        <div>
            <label for="recipeBoardTitle">제목</label>
            <input type="text" name="recipeBoardTitle" required>
        </div>
        <div>
            <label for="recipeBoardContent">내용</label>
            <textarea name="recipeBoardContent" rows="5" required></textarea>
        </div>
        <div>
            <label for="memberId">작성자 ID</label>
            <input type="number" name="memberId" required>
         </div>
        <div>
            <label>타입</label>
                <c:forEach var="type" items="${types}">
                    <input type="checkbox" name="typeId" value="${type.typeId}" id="type${type.typeId}">
                    <label for="type${type.typeId}">${type.typeName}</label>
                    <br>
                </c:forEach>
        </div>
        <div>
            <label>재료</label>
                <c:forEach var="ingredient" items="${ingredients}">
                    <input type="checkbox" name="ingredientIds" value="${ingredient.ingredientId}" id="ingredient${ingredient.ingredientId}">
                    <label for="ingredient${ingredient.ingredientId}">${ingredient.ingredientName}</label>
                    <br>
                </c:forEach>
        </div>
        <div>
            <label>방법</label>
                <c:forEach var="method" items="${methods}">
                    <input type="checkbox" name="methodId" value="${method.methodId}" id="method${method.methodId}">
                    <label for="method${method.methodId}">${method.methodName}</label>
                    <br>
                </c:forEach>
         </div>
        <div>
            <label>상황</label>
                <c:forEach var="situation" items="${situations}">
                    <input type="checkbox" name="situationId" value="${situation.situationId}" id="situation${situation.situationId}">
                    <label for="situation${situation.situationId}">${situation.situationName}</label>
                    <br>
                </c:forEach>
        </div>
        <button type="submit">저장</button>
    </form>
</body>
</html>