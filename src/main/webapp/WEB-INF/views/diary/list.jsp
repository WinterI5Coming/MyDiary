<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"
></script>
<script src="${pageContext.request.contextPath}/resources/js/list.js"
	defer
></script>
<title>Insert title here</title>
<style type="text/css">
li.completed .titleDiv,
li.completed .dueDateDiv {
	text-decoration: line-through;
	color: gray;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="container mt-5">
		<div class="row">

			<h1>다이어리 목록</h1>
			
			<div>
				<button class="btn btn-primary" id="searchBtn">🔎검색옵션</button>buutton>
			</div>
			
			<div class="card" id="searchFormCard" style="display:none;">
				<div class="card-body">
					<form action="/diary/search" method="POST">

						<div class="mb-3 mt-3">
							<label for="searchWord" class="form-label">제목 검색 :</label> <input
								type="text" class="form-control" id="searchWord"
								placeholder="검색어를 입력하세요..." name="searchWord"
							> <input type="hidden" name="searchTypes" value="title">
						</div>

						<div>
							<label for="finishedSelect" class="form-label">Select
								list</label> <select class="form-select" id="finishedSelect"
								name="finished"
							>
								<option value="">모두보기</option>
								<option value="0">미완료</option>
								<option value="1">완료</option>
							</select>
						</div>
						
						<div>
							<label for="from" class="form-label">dueDate (From):</label>
							<input type="date" class="form-control" id="from" name="from">
						</div>
						
						<div>
							<label for="to" class="form-label">dueDate (To):</label>
							<input type="date" class="form-control" id="to" name="to">
						</div>
						
						<div>
							<button type="submit" class="btn btn-primary">검색</button>
						</div>
						
					</form>
				</div>
			</div>

			<div>${diaryList }</div>

			<ul class="list-group">
				<c:forEach var="diary" items="${diaryList }">
					<li
						class="list-group-item d-flex align-items-center ${diary.finished ? 'completed' : '' }"
						id="dlist-${diary.dno }"
					><input class="form-check-input finishedCheckbox" type="checkbox"
						id="check1" data-dno="${diary.dno }"
						<c:if test="${diary.finished }">checked</c:if>
					>
						<div class="titleDiv">${diary.title }</div>
						<div class="dueDateDiv">${diary.dueDate }</div>

						<button type="button"
							class="btn btn-outline-secondary btn-sm modifyBtn"
							data-dno="${diary.dno }" data-title="${diary.title }"
							data-date="${diary.dueDate }"
						>수정</button></li>


				</c:forEach>
			</ul>

		</div>
	</div>

	<!-- The Modal -->
	<div class="modal" id="modifyModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Modal Heading</h4>
					<button type="button" class="btn-close closeModal"
						data-bs-dismiss="modal"
					></button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					Modal body.. <input type="hidden" id="modifyDno" name="dno" />
					<div class="mb-3 mt-3">
						<label for="modifyTitle">Title : </label> <input type="text"
							class="form-control" id="modifyTitle" name="title"
						>

						<div class="mb-3 mt-3">
							<label for="modifyDueDate">DueDate : </label> <input type="date"
								class="form-control" id="modifyDueDate" name="dueDateStr"
							>


						</div>

					</div>

					<!-- Modal footer -->
					<div class="modal-footer">

						<button type="button" class="btn btn-success"
							onclick="modifyDiary();"
						>Modify</button>

						<button type="button" class="btn btn-danger closeModal"
							data-bs-dismiss="modal"
						>Close</button>
					</div>

				</div>
			</div>
		</div>
	</div>

	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>