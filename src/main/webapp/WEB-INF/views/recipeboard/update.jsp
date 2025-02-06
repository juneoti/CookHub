<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<title>Update Recipe</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap"
    rel="stylesheet">
<style>
/* 기존 스타일을 기본으로 하되, 일부 스타일을 추가 및 개선 */
body {
    font-family: 'Noto Sans KR', sans-serif;
    margin: 0;
    padding: 20px;
    background-color: #f8f9fa;
}

h1 {
    text-align: center;
    margin-bottom: 40px;
    font-size: 2.5rem;
    color: #343a40;
}

form {
    max-width: 900px;
    margin: 0 auto;
    padding: 40px;
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    border: 1px solid #e0e0e0;
}

.form-group {
    margin-bottom: 20px;
    display: flex;
    flex-direction: column;
}

.form-group label {
    font-weight: bold;
    margin-bottom: 8px;
    color: #495057;
}

.form-group input[type="text"],
.form-group textarea,
.form-group select,
.form-group input[type="file"] {
    padding: 12px;
    border: 1px solid #ced4da;
    border-radius: 8px;
    font-size: 1rem;
    width: 100%;
    box-sizing: border-box;
}

.form-group input[type="text"]:focus,
.form-group textarea:focus,
.form-group select:focus {
    outline: none;
    border-color: #80bdff;
    box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, .25);
}

button[type="submit"],
button[type="button"] {
    background-color: #007bff;
    color: white;
    padding: 12px 25px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 1.1rem;
    transition: background-color 0.3s ease;
    margin-top: 20px;
}

button[type="submit"]:hover,
button[type="button"]:hover {
    background-color: #0056b3;
}

/* 썸네일 이미지 미리보기 */
.thumbnail-preview {
    margin-top: 15px;
    text-align: center;
}

.thumbnail-preview img {
    max-width: 200px;
    max-height: 200px;
    border: 2px solid #ddd;
    border-radius: 8px;
}

.noThumbnailMessage {
    color: red;
    text-align: center;
    font-size: 1rem;
    margin-top: 10px;
}

/* 해시태그 입력 및 리스트 */
.hashtag-container {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    margin-top: 15px;
}

.hashtag {
    display: inline-flex;
    align-items: center;
    background-color: #f1f1f1;
    border-radius: 15px;
    padding: 5px 12px;
    margin: 5px;
    font-size: 1rem;
}

.hashtag .remove-hashtag {
    margin-left: 8px;
    cursor: pointer;
    font-weight: bold;
    color: red;
}

/* 선택 컨테이너 */
.selection-container {
    margin-bottom: 25px;
    padding: 15px;
    border: 1px solid #dee2e6;
    border-radius: 8px;
    background-color: #f9f9f9;
}

.selection-container h3 {
    font-size: 1.2rem;
    margin-bottom: 10px;
    color: #495057;
    border-bottom: 1px solid #dee2e6;
    padding-bottom: 8px;
}

/* 재료 입력 */
.ingredient-row {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
}

.ingredient-row input {
    margin-right: 12px;
    padding: 10px;
    border-radius: 6px;
    border: 1px solid #ced4da;
}

.ingredient-row button {
    padding: 8px 15px;
    background-color: #dc3545;
    color: white;
    border-radius: 6px;
    cursor: pointer;
}

.ingredient-row button:hover {
    background-color: #c82333;
}

/* 조리 순서 입력 */
.step-row {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
    flex-wrap: wrap;
}

.step-row label {
    font-weight: bold;
    width: 100px;
}

.step-row textarea {
    padding: 10px;
    border: 1px solid #ced4da;
    border-radius: 6px;
    flex-grow: 1;
    font-size: 1rem;
}

.step-row button {
    padding: 8px 15px;
    background-color: #dc3545;
    color: white;
    border-radius: 6px;
    cursor: pointer;
}

.step-row button:hover {
    background-color: #c82333;
}
.step-preview {
    margin-top: 10px;
    text-align: center;
}

.step-preview img {
    max-width: 120px;
    max-height: 120px;
    border: 1px solid #ddd;
    border-radius: 6px;
    display: none;
}

/* 요리 정보 입력 스타일 */
.recipe-info-container {
    display: flex;
    flex-wrap: wrap;
    margin-bottom: 25px;
    border: 1px solid #dee2e6;
    padding: 15px;
    border-radius: 8px;
    background-color: #f9f9f9;
}

.recipe-info-container .form-group {
    width: 30%;
    margin-right: 20px;
}

.recipe-info-container .form-group label {
    margin-bottom: 8px;
    font-weight: bold;
}

.recipe-info-container select {
    padding: 10px;
    border-radius: 6px;
    border: 1px solid #ced4da;
    font-size: 1rem;
    width: 100%;
    box-sizing: border-box;
}

@media (max-width: 768px) {
    .recipe-info-container .form-group {
        width: 100%;
        margin-bottom: 15px;
    }
    form {
        padding: 20px;
    }
}
</style>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // 해시태그 관련 요소
        const hashtagInput = document.getElementById("hashtagInput");
        const hashtagList = document.getElementById("hashtagList");
        const hashtagsHiddenInput = document.getElementById("hashtagsHiddenInput");

        // 기존 해시태그를 로컬 변수에 저장 및 UI에 표시
        let hashtags = [];
       const initialHashtags = "${hashtags.hashtagId}";

        if (initialHashtags) {
            hashtags = initialHashtags.split(",").filter(tag => tag.trim() !== "");
            hashtags.forEach(addHashtag); // 기존 태그 추가
        }


        // 엔터 키 입력 시 해시태그 추가 이벤트 핸들러
        hashtagInput.addEventListener("keydown", function (e) {
            if (e.key === "Enter") {
                e.preventDefault(); // 폼 제출 방지
                const value = hashtagInput.value.trim(); // 공백 제거
                if (value && !hashtags.includes(value)) {
                    console.log("New hashtag entered:", value); // 디버깅: 입력값 확인
                    addHashtag(value);
                    hashtagInput.value = ""; // 입력 필드 초기화
                } else if (hashtags.includes(value)) {
                    console.log("Duplicate hashtag ignored:", value); // 중복 확인
                    alert("This hashtag is already added.");
                } else {
                    console.log("Invalid or empty hashtag ignored."); // 유효하지 않은 값
                }
            }
        });

        // 해시태그 추가 함수
        function addHashtag(value) {
		    console.log("Adding hashtag to UI:", value); // 디버깅용
		
		    // 해시태그 목록에 추가
		    hashtags.push(value);
		
		    // UI에 해시태그 추가
		    const hashtagElement = document.createElement("div");
		    hashtagElement.className = "hashtag";
		
		    // 해시태그 텍스트 추가
		    const hashtagText = document.createTextNode("#" + value); // 문자열 결합으로 해시태그 표시
		    hashtagElement.appendChild(hashtagText);
		
		    // X 버튼 추가
		    const removeButton = document.createElement("span");
		    removeButton.className = "remove-hashtag";
		    removeButton.textContent = "x";
		    removeButton.addEventListener("click", function () {
		        removeHashtag(value, hashtagElement);
		    });
		
		    hashtagElement.appendChild(removeButton);
		    hashtagList.appendChild(hashtagElement);
		
		    console.log("Hashtag added to UI element:", hashtagElement); // 디버깅용
		
		    // 히든 필드 업데이트
		    updateHiddenInput();
		}


        // 해시태그 제거 함수
        function removeHashtag(value, element) {
            console.log("Hashtag removed:", value); // 디버깅: 제거된 값 확인
            hashtags = hashtags.filter((tag) => tag !== value); // 목록에서 제거
            hashtagList.removeChild(element); // UI에서 제거

            // 히든 필드 업데이트
            updateHiddenInput();
        }

        // 히든 필드 업데이트
        function updateHiddenInput() {
            hashtagsHiddenInput.value = hashtags.join(","); // 콤마로 연결된 문자열 저장
            console.log("Updated hidden input value:", hashtagsHiddenInput.value); // 디버깅: 숨겨진 필드 값 확인
        }
    });
    
    // 썸네일 이미지 미리보기 및 유효성 검사
        function validateAndPreviewThumbnail(input) {
            const previewImage = document.getElementById('thumbnailPreview');
             const noThumbnailMessage = document.getElementById('noThumbnailMessage');
            const allowedExtensions = ['jpeg', 'jpg', 'png', 'gif'];

            if (input.files && input.files[0]) {
                const file = input.files[0];
                const fileName = file.name.toLowerCase();
                const fileExtension = fileName.split('.').pop();

                // 유효성 검사: 확장자 체크
                if (!allowedExtensions.includes(fileExtension)) {
                    alert('Invalid file type. Please upload an image (JPEG, PNG, GIF).');
                    input.value = ''; // 파일 입력 초기화
                    previewImage.style.display = 'none';
                     noThumbnailMessage.style.display = 'block';
                    return;
                }
                 // 이미지 파일 미리보기
                const reader = new FileReader();
                reader.onload = function (e) {
                    previewImage.src = e.target.result;
                     previewImage.style.display = 'block';
                      noThumbnailMessage.style.display = 'none';
                };
                reader.readAsDataURL(file);
            } else {
                   // 파일이 선택되지 않았을 경우 기존 이미지 표시 또는 숨기기
                const existingThumbnail = "${recipeBoard.thumbnail}"; // 기존 썸네일 경로
               if (existingThumbnail && existingThumbnail !== "") {
                    previewImage.src = "${pageContext.request.contextPath}/upload/" + existingThumbnail;
                   previewImage.style.display = 'block';
                 noThumbnailMessage.style.display = 'none';

                } else {
                    previewImage.style.display = 'none';
                    noThumbnailMessage.style.display = 'block';
              }
            }
        }
        document.addEventListener("DOMContentLoaded", function () {
        	// 재료 입력 관련 요소
           const ingredientInputs = document.getElementById("ingredientInputs");
           const addIngredientButton = document.getElementById("addIngredient");

            // 기존 재료 목록 표시
            const initialIngredients = ${recipeBoard.ingredientsJson};
            if (initialIngredients && Array.isArray(initialIngredients)) {
                initialIngredients.forEach(function(ingredient, index) {
                     addIngredientRow(ingredient, index);
                  });
            }else {
            	 addIngredientRow();
            }


         	// 재료 추가 함수
             function addIngredientRow(ingredient = {}, index = null) {
                 const newRow = document.createElement("div");
                    newRow.className = "ingredient-row";
                  let ingredientIndex = index !== null ? index : ingredientInputs.querySelectorAll('.ingredient-row').length;

                      newRow.innerHTML = `
                       <input type="text" name="ingredientName[${ingredientIndex}]" placeholder="예) 돼지고기" value="${ingredient.ingredientName || ''}" required>
                       <input type="text" name="ingredientAmount[${ingredientIndex}]" placeholder="예) 10(수량)" value="${ingredient.ingredientAmount || ''}" required>
                      <input type="text" name="ingredientUnit[${ingredientIndex}]" placeholder="예) g,ml(단위)" value="${ingredient.ingredientUnit || ''}" required>
                       <input type="text" name="ingredientNote[${ingredientIndex}]" placeholder="예) (비고)" value="${ingredient.ingredientNote || ''}">
                      <button type="button" class="remove-ingredient">삭제</button>
                   `;
                   ingredientInputs.appendChild(newRow);
                }


            // 이벤트 위임: 삭제 버튼
            ingredientInputs.addEventListener('click', function (event) {
                if (event.target.classList.contains('remove-ingredient')) {
                    event.target.closest('.ingredient-row').remove();
                }
            });

            // 재료 추가 버튼 클릭 이벤트
            addIngredientButton.addEventListener("click", addIngredientRow);
        });
     document.addEventListener("DOMContentLoaded", function () {
        	// 조리 순서 입력 관련 요소
           const stepInputs = document.getElementById("stepInputs");
            const addStepButton = document.getElementById("addStep");
             let stepCounter = ${fn:length(recipeBoard.steps) + 1} || 2;

           // 기존 조리 순서 표시
           const initialSteps = ${recipeBoard.stepsJson};
           if (initialSteps && Array.isArray(initialSteps)) {
                 initialSteps.forEach(function(step, index) {
                    addStepRow(step,index);
                 });
            }else{
                addStepRow();
            }


           // 조리 순서 추가 함수
           function addStepRow(step = {}, index = null) {
        	   const newRow = document.createElement("div");
               newRow.className = "step-row";
               let stepIndex = index !== null ? index : stepCounter;

               newRow.innerHTML = `
                   <label>Step ${stepIndex}</label>
                   <textarea name="stepDescription[${stepIndex}]" placeholder="예) 소고기는 기름기를 떼어내고 적당한 크기로 썰어주세요." required>${step.stepDescription || ''}</textarea>
                  <input type="file" name="stepImage[${stepIndex}]" accept="image/*">
                   <input type="number" name="stepOrder[${stepIndex}]" value="${stepIndex}" style="width: 80px;">
                    <button type="button" class="remove-step">삭제</button>
                     <div class="step-preview">
                        <img src="${step.stepImage ? '${pageContext.request.contextPath}/upload/' + step.stepImage : '#'}" alt="Step Preview" style="display: ${step.stepImage ? 'block' : 'none'};">
                    </div>
              `;
                stepInputs.appendChild(newRow);

               // 이미지 미리보기
              const fileInput = newRow.querySelector('input[type="file"]');
              const previewImage = newRow.querySelector('.step-preview img');


                fileInput.addEventListener('change', function() {
                    if(fileInput.files && fileInput.files[0]){
                       const reader = new FileReader();
                       reader.onload = function (e) {
                            previewImage.src = e.target.result;
                            previewImage.style.display = 'block';
                         };
                         reader.readAsDataURL(fileInput.files[0]);
                    } else {
                          previewImage.src = '${step.stepImage ? '${pageContext.request.contextPath}/upload/' + step.stepImage : "#"}';
                         if(!step.stepImage){
                             previewImage.style.display = 'none';
                         }

                    }
                });

                const removeButton = newRow.querySelector('.remove-step');
                 removeButton.addEventListener('click', function() {
                    newRow.remove();
                 });
                if(index == null){
                   stepCounter++;
                }
            }
               // 이벤트 위임: 삭제 버튼
                  stepInputs.addEventListener('click', function(event) {
                      if (event.target.classList.contains('remove-step')) {
                           event.target.closest('.step-row').remove();
                       }
                    });
               // 파일 변경 시 미리보기 업데이트 이벤트
                   stepInputs.addEventListener('change', function(event){
                    if (event.target.matches('input[type="file"]')) {
                        const fileInput = event.target;
                       const previewImage = fileInput.closest('.step-row').querySelector('.step-preview img');
                         if (fileInput.files && fileInput.files[0]) {
                            const reader = new FileReader();
                           reader.onload = function (e) {
                            previewImage.src = e.target.result;
                              previewImage.style.display = 'block';
                           };
                            reader.readAsDataURL(fileInput.files[0]);
                        } else {
                           previewImage.src = '';
                           previewImage.style.display = 'none';
                         }
                    }
              });

            // 조리 순서 추가 버튼 클릭 이벤트
            addStepButton.addEventListener("click", addStepRow);
      });
    </script>
</head>
<body>
    <h1>레시피 수정</h1>
    <form action="${pageContext.request.contextPath}/recipeboard/update" method="post" enctype="multipart/form-data">
        <input type="hidden" name="recipeBoardId" value="${recipeBoard.recipeBoardId}">
        <div class="form-group">
            <label for="recipeBoardTitle">레시피 제목</label>
            <input type="text" id="recipeBoardTitle" name="recipeBoardTitle" value="${recipeBoard.recipeBoardTitle}" required>
        </div>
        <div class="form-group">
            <label for="recipeBoardContent">레시피 설명</label>
            <textarea id="recipeBoardContent" name="recipeBoardContent" rows="3" required>${recipeBoard.recipeBoardContent}</textarea>
        </div>
        <div class="form-group">
            <label for="recipeTip">요리 팁</label>
             <textarea id="recipeTip" name="recipeTip" rows="3">${recipeBoard.recipeTip}</textarea>
        </div>
         <div class="form-group">
           	<label for="thumbnail">썸네일 이미지</label>
           	<input type="file" id="thumbnail" name="thumbnail" accept="image/*" onchange="validateAndPreviewThumbnail(this)">
               <div class="thumbnail-preview">
                   <img id="thumbnailPreview" src="${recipeBoard.thumbnail ? pageContext.request.contextPath + '/upload/' + recipeBoard.thumbnail : '#'}" alt="Thumbnail Preview" style="display: ${recipeBoard.thumbnail ? 'block' : 'none'};">
               </div>
              <p id="noThumbnailMessage" class="noThumbnailMessage" style="display: ${recipeBoard.thumbnail ? 'none' : 'block'}">No thumbnail selected.</p>
        </div>
           <%-- 종류별 선택 컨테이너 --%>
       <div class="selection-container">
            <h3>종류별</h3>
              <select name="typeId" required>
                 <%-- 종류 목록을 반복하여 드롭다운 옵션 생성 --%>
                 <c:forEach var="type" items="${typesList}">
                    <c:if test="${type.typeId != 1}">
                         <option value="${type.typeId}" ${recipeBoard.typeId == type.typeId ? 'selected' : ''}>${type.typeName}</option>
                    </c:if>
                 </c:forEach>
             </select>
        </div>
        <%-- 상황별 선택 컨테이너 --%>
        <div class="selection-container">
            <h3>상황별</h3>
            <select name="situationId" required>
                 <%-- 상황 목록을 반복하여 드롭다운 옵션 생성 --%>
                <c:forEach var="situation" items="${situationsList}">
                   <c:if test="${situation.situationId != 1}">
                        <option value="${situation.situationId}" ${recipeBoard.situationId == situation.situationId ? 'selected' : ''}>${situation.situationName}</option>
                    </c:if>
                </c:forEach>
             </select>
        </div>
         <%-- 방법별 선택 컨테이너 --%>
        <div class="selection-container">
            <h3>방법별</h3>
           <select name="methodId" required>
                 <%-- 방법 목록을 반복하여 드롭다운 옵션 생성 --%>
               <c:forEach var="method" items="${methodsList}">
                   <c:if test="${method.methodId != 1}">
                        <option value="${method.methodId}" ${recipeBoard.methodId == method.methodId ? 'selected' : ''}>${method.methodName}</option>
                    </c:if>
               </c:forEach>
           </select>
        </div>
        <%-- 재료별 선택 컨테이너 --%>
        <div class="selection-container">
             <h3>재료별</h3>
             <ul>
                <%-- 재료 목록을 반복하여 체크박스 생성 --%>
                <c:forEach var="ingredient" items="${ingredientsList}">
                   <c:if test="${ingredient.ingredientId != 1}">
                     <li>
                            <input type="checkbox" name="ingredientIds" value="${ingredient.ingredientId}"
                                <c:if test="${fn:contains(recipeBoard.ingredientIds, ingredient.ingredientId)}">checked</c:if>>
                              ${ingredient.ingredientName}
                        </li>
                   </c:if>
                </c:forEach>
            </ul>
        </div>
         <%-- 해시태그 입력 컨테이너 --%>
        <div class="form-group">
            <label for="hashtagInput">해시태그</label>
            <input type="text" id="hashtagInput" placeholder="해시태그를 입력하세요. (엔터로 추가)" >
             <input type="hidden" id="hashtagsHiddenInput" name="hashtags" >
             <div class="hashtag-container" id="hashtagList"></div>
         </div>
         <%-- 재료 입력 컨테이너 --%>
        <div class="selection-container">
            <h3>재료 입력</h3>
            <div id="ingredientInputs">
                 </div>
           <button type="button" id="addIngredient">재료 추가</button>
        </div>
        <%-- 조리 순서 입력 컨테이너 --%>
        <div class="selection-container">
           <h3>조리 순서</h3>
            <div id="stepInputs">
            </div>
           <button type="button" id="addStep">조리 순서 추가</button>
        </div>
        <%-- 요리 정보 컨테이너 --%>
        <div class="recipe-info-container">
            <div class="form-group">
                <label for="time">시간</label>
                 <select id="time" name="time" required>
                    <option value="10" ${recipeBoard.time == 10 ? 'selected' : ''}>10분</option>
                     <option value="20" ${recipeBoard.time == 20 ? 'selected' : ''}>20분</option>
                     <option value="30" ${recipeBoard.time == 30 ? 'selected' : ''}>30분</option>
                    <option value="40" ${recipeBoard.time == 40 ? 'selected' : ''}>40분</option>
                    <option value="50" ${recipeBoard.time == 50 ? 'selected' : ''}>50분</option>
                     <option value="60" ${recipeBoard.time == 60 ? 'selected' : ''}>60분</option>
                 </select>
            </div>
             <div class="form-group">
                 <label for="difficulty">난이도</label>
                <select id="difficulty" name="difficulty" required>
                     <option value="아주쉬움" ${recipeBoard.difficulty == '아주쉬움' ? 'selected' : ''}>아주 쉬움</option>
                    <option value="쉬움" ${recipeBoard.difficulty == '쉬움' ? 'selected' : ''}>쉬움</option>
                    <option value="보통" ${recipeBoard.difficulty == '보통' ? 'selected' : ''}>보통</option>
                    <option value="어려움" ${recipeBoard.difficulty == '어려움' ? 'selected' : ''}>어려움</option>
                    <option value="매우어려움" ${recipeBoard.difficulty == '매우어려움' ? 'selected' : ''}>매우 어려움</option>
                </select>
             </div>
            <div class="form-group">
                <label for="servings">인분</label>
               <select id="servings" name="servings" required>
                    <option value="1" ${recipeBoard.servings == 1 ? 'selected' : ''}>1인분</option>
                     <option value="2" ${recipeBoard.servings == 2 ? 'selected' : ''}>2인분</option>
                     <option value="3" ${recipeBoard.servings == 3 ? 'selected' : ''}>3인분</option>
                   <option value="4" ${recipeBoard.servings == 4 ? 'selected' : ''}>4인분</option>
                   <option value="5" ${recipeBoard.servings == 5 ? 'selected' : ''}>5인분</option>
                   <option value="6" ${recipeBoard.servings == 6 ? 'selected' : ''}>6인분</option>
                    <option value="7" ${recipeBoard.servings == 7 ? 'selected' : ''}>7인분</option>
                    <option value="8" ${recipeBoard.servings == 8 ? 'selected' : ''}>8인분</option>
                    <option value="9" ${recipeBoard.servings == 9 ? 'selected' : ''}>9인분</option>
                    <option value="10" ${recipeBoard.servings == 10 ? 'selected' : ''}>10인분</option>
                </select>
            </div>
       </div>
        <button type="submit">수정</button>
    </form>
</body>
</html>