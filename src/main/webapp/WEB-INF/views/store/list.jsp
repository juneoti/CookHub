<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 목록</title>
    <style>
     body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
        }

        .product-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .product-card {
            width: 22%;
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
            background-color: #fff;
            cursor: pointer;
            text-align: center;
            transition: transform 0.2s;
        }

        .product-card:hover {
            transform: scale(1.05);
        }

        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .product-info {
            padding: 10px;
        }

        .product-title {
            font-size: 18px;
            margin: 5px 0;
        }

        .product-meta {
            color: #777;
        }

        .register-button {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            font-size: 16px;
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
        }

        .register-button:hover {
            background-color: #45a049;
        }

        .pagination-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination-link {
            margin: 0 5px;
            padding: 5px 10px;
            border: 1px solid #ddd;
            text-decoration: none;
            color: #333;
        }

        .pagination-link.active {
            font-weight: bold;
            background-color: #4caf50;
            color: white;
        }
        
		.purchase-button {
		    display: block;
		    width: 80%;
		    margin: 10px auto;
		    padding: 10px;
		    background-color: #ff5722;
		    color: white;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    font-size: 14px;
		}
		
		.purchase-button:hover {
		    background-color: #e64a19;
		}

    </style>
</head>
<body>

    <h2>상품 목록</h2>

    <a href="${pageContext.request.contextPath}/store/register" class="register-btn">상품 등록</a>

    <!-- 상품 리스트 -->
    <div class="product-list">
        <c:choose>
            <c:when test="${not empty productList}">
				<c:forEach var="products" items="${productList}">
				    <div class="product-card">
				        <img class="product-image" src="${pageContext.request.contextPath}/uploads/${products.productImagePath}" 
				             alt="상품 이미지"
				             onerror="this.src='${pageContext.request.contextPath}/uploads/product_images/default.png';">
				        <div class="product-info">
				            <h3 class="product-title">${products.productName}</h3>
				            <p class="product-meta">
				                가격: ${products.productPrice}원 | 재고: ${products.stock}
				            </p>
				            <button class="purchase-button" onclick="purchaseProduct('${products.productId}')">구매하기</button>
				        </div>
				    </div>
				</c:forEach>

            </c:when>
            <c:otherwise>
                <p>등록된 상품이 없습니다.</p>
            </c:otherwise>
        </c:choose>
    </div>

<div class="pagination-container">
    <c:if test="${pageMaker.prev}">
        <a class="pagination-link" 
           href="?pageNum=${pageMaker.startNum - 1}&pageSize=${pagination.pageSize}">이전</a>
    </c:if>
    
    <c:forEach var="pageNum" begin="${pageMaker.startNum}" end="${pageMaker.endNum}">
        <a class="pagination-link ${pagination.pageNum == pageNum ? 'active' : ''}" 
           href="?pageNum=${pageNum}&pageSize=${pagination.pageSize}">${pageNum}</a>
    </c:forEach>

    <c:if test="${pageMaker.next}">
        <a class="pagination-link" 
           href="?pageNum=${pageMaker.endNum + 1}&pageSize=${pagination.pageSize}">다음</a>
    </c:if>
</div>

	<script>
	function purchaseProduct(productId) {
	    location.href = '${pageContext.request.contextPath}/store/purchase/' + productId;
	}
	</script>
</body>
</html>
