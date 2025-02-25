<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
<img src="${pageContext.request.contextPath}/uploads/${product.productImagePath}"
     alt="상품 이미지"
     onerror="this.src='${pageContext.request.contextPath}/uploads/product_images/default.png';"
     style="max-width: 100%; max-height: 300px;">
<p>상품명 : ${product.productName}</p>
<p>가격 : ${product.productPrice}원</p>
<p>재고 : ${product.stock}개</p>  <%-- 재고 표시 --%>
<div class="button">
    <div class="button_quantity">
        주문수량
        <span>
            <button class="minus_btn">-</button>
        </span>
        <input type="text" class="quantity_input" value="1">
        <span>
		    <button class="plus_btn">+</button>
		</span>
    </div>
    <div class="button_set">
        <button class="btn_cart">장바구니</button>
        <button class="purchase-button" onclick="purchaseProduct('${product.productId}', '${product.productName}', ${product.productPrice})">구매하기</button>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
    // 재고량
    let stock = ${product.stock};

    // 수량 버튼 조작
    let quantity = $(".quantity_input").val();
    $(".plus_btn").on("click", function () {
        if (quantity < stock) {
            $(".quantity_input").val(++quantity);
        } else {
            alert("재고량이 부족합니다.");
        }

    });
    $(".minus_btn").on("click", function () {
        if (quantity > 1) {
            $(".quantity_input").val(--quantity);
        }
    });

    // 장바구니 버튼
    $(".btn_cart").on("click", function () {
        let productCount = $(".quantity_input").val();

        // AJAX를 사용하여 서버에 데이터를 전송
        if (productCount > stock) {
            alert("재고량이 부족합니다.");
            return;
        }

        $.ajax({
            type: "POST",
            url: "../cart/add/${product.productId}", // 컨트롤러의 addToCart 메서드 호출
            data: {productCount: productCount}, // 서버에 전달할 데이터
            success: function (response) {
                // 성공적으로 장바구니에 추가되었을 때 처리
                alert("장바구니에 추가되었습니다!");
                window.location.href = "../cart";  // 장바구니 페이지로 이동
            },
            error: function (error) {
                // 오류 발생 시 처리
                alert("오류가 발생했습니다.");
            }
        });
    });

    // 바로구매 버튼
    function purchaseProduct(productId, productName, productPrice) {
        let productCount = $(".quantity_input").val();
        if (productCount > stock) {
            alert("재고량이 부족합니다.");
            return;
        }

        let form = document.createElement("form");
        form.method = "POST"; // POST 사용 (보안 강화)
        form.action = '${pageContext.request.contextPath}/store/purchase';

        let csrfInput = document.createElement("input");
        csrfInput.type = "hidden";
        csrfInput.name = "${_csrf.parameterName}";
        csrfInput.value = "${_csrf.token}"; // CSRF 방어

        let input1 = document.createElement("input");
        input1.type = "hidden";
        input1.name = "productId";
        input1.value = productId;

        let input2 = document.createElement("input");
        input2.type = "hidden";
        input2.name = "productName";
        input2.value = productName;

        let input3 = document.createElement("input");
        input3.type = "hidden";
        input3.name = "productPrice";
        input3.value = productPrice;

        form.appendChild(csrfInput);
        form.appendChild(input1);
        form.appendChild(input2);
        form.appendChild(input3);
        document.body.appendChild(form);
        form.submit();
    }

    // 숫자만 입력하도록 제한 및 재고량 체크
    $(".quantity_input").on("input", function () {
        let value = $(this).val();
        if (!/^[0-9]*$/.test(value)) { // 정규식으로 숫자만 허용
            alert("숫자만 입력하세요.");
            $(this).val(value.replace(/[^0-9]/g, '')); // 숫자 이외의 문자 제거
        }

        quantity = parseInt($(this).val()) || 1; // 현재 quantity 업데이트

        if(quantity > stock) {
            alert("재고량이 부족합니다.");
            $(this).val(stock);
            quantity = stock;
        }

        if(quantity < 1) {
            quantity = 1;
            $(this).val(1);
        }

    });
</script>
</body>
</html>