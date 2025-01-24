<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- css 파일 불러오기 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/image.css">
<title>글 작성 페이지</title>
<style type="text/css">
li {
	display: inline-block;
}
</style>
</head>
<body>
	
	<div class="image-upload">
		<h2>이미지 파일 업로드</h2>
		<p>* 이미지 파일은 최대 1개까지 가능합니다.</p>
		<p>* 최대 용량은 10MB 입니다.</p>
		<div class="image-drop"></div>
		<h2>선택한 이미지 파일 :</h2>
		<div class="image-list"></div>
	</div>

		<div class="reviewAttachDTOImg-list">
	</div>
	
	<div class="reviewAttachDTOFile-list">
	</div>

	<button id="registerRecipeReview">등록</button>

	<script src="${pageContext.request.contextPath }/resources/js/image.js"></script>

	<script>
		// ajaxSend() : AJAX 요청이 전송되려고 할 때 실행할 함수를 지정
		// ajax 요청을 보낼 때마다 CSRF 토큰을 요청 헤더에 추가하는 코드
		$(document).ajaxSend(function(e, xhr, opt){
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			xhr.setRequestHeader(header, token);
		});
	
		$(document).ready(function() {
			// regsiterForm 데이터 전송
			$('#registerBoard').click(function() {
				var title = $('#boardTitle').val().trim(); // 문자열의 양 끝 공백 제거
	            var content = $('#boardContent').val().trim();

	            if (title === '' || content === '') {
	                alert("제목과 내용을 모두 입력해주세요.");
	                return;
	            }
	            
				// form 객체 참조
				var registerForm = $('#registerForm');
				
				// attachDTOImg-list의 각 input 태그 접근
				var i = 0;
				$('.attachDTOImg-list input[name="attachDTO"]').each(function(){
					console.log(this);
					// JSON attachDTO 데이터를 object 변경
					var attachDTO = JSON.parse($(this).val());
					// attachPath input 생성
					var inputPath = $('<input>').attr('type', 'hidden')
							.attr('name', 'attachList[' + i + '].attachPath');
					inputPath.val(attachDTO.attachPath);
					
					// attachRealName input 생성
					var inputRealName = $('<input>').attr('type', 'hidden')
							.attr('name', 'attachList[' + i + '].attachRealName');
					inputRealName.val(attachDTO.attachRealName);
					
					// attachChgName input 생성
					var inputChgName = $('<input>').attr('type', 'hidden')
							.attr('name', 'attachList[' + i + '].attachChgName');
					inputChgName.val(attachDTO.attachChgName);
					
					// attachExtension input 생성
					var inputExtension = $('<input>').attr('type', 'hidden')
							.attr('name', 'attachList[' + i + '].attachExtension');
					inputExtension.val(attachDTO.attachExtension);
					
					// form에 태그 추가
					registerForm.append(inputPath);
					registerForm.append(inputRealName);
					registerForm.append(inputChgName);
					registerForm.append(inputExtension);
					
					i++;
				});
				
				// attachDTOFile-list의 각 input 태그 접근
				$('.attachDTOFile-list input[name="attachDTO"]').each(function(){
					console.log(this);
					// JSON attachDTO 데이터를 object 변경
					var attachDTO = JSON.parse($(this).val());
					// attachPath input 생성
					var inputPath = $('<input>').attr('type', 'hidden')
							.attr('name', 'attachList[' + i + '].attachPath');
					inputPath.val(attachDTO.attachPath);
					
					// attachRealName input 생성
					var inputRealName = $('<input>').attr('type', 'hidden')
							.attr('name', 'attachList[' + i + '].attachRealName');
					inputRealName.val(attachDTO.attachRealName);
					
					// attachChgName input 생성
					var inputChgName = $('<input>').attr('type', 'hidden')
							.attr('name', 'attachList[' + i + '].attachChgName');
					inputChgName.val(attachDTO.attachChgName);
					
					// attachExtension input 생성
					var inputExtension = $('<input>').attr('type', 'hidden')
							.attr('name', 'attachList[' + i + '].attachExtension');
					inputExtension.val(attachDTO.attachExtension);
					
					// form에 태그 추가
					registerForm.append(inputPath);
					registerForm.append(inputRealName);
					registerForm.append(inputChgName);
					registerForm.append(inputExtension);
					
					i++;
				});
				registerForm.submit();
			});

		});
		
		
	</script>


</body>
</html>



