<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"
></script>
<script src="${pageContext.request.contextPath}/resources/js/register.js"></script>
<title>다이어리 등록</title>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="container mt-5">
		<div class="row">
			<h1>다이어리 등록</h1>

			<form action="/diary/register" method="POST">

				<div class="mb-3 mt-3">
					<label for="title" class="form-label">Title:</label><span
						id="titleError"
					></span> <input type="text" class="form-control" id="title"
						placeholder="제목" name="title"
					>
				</div>

				<div class="mb-3">
					<label for="dueDate" class="form-label">Due Date:</label><span
						id="dueDateError"
					></span> <input
						type="date" class="form-control" id="dueDate" name="dueDateStr"
					>
				</div>

				<div class="mb-3 mt-3">
					<!-- 					<label for="writer" class="form-label">Writer:</label><span -->
					<!-- 						id="writerError" -->
					<!-- 					></span> -->
					<input
						type="hidden" class="form-control" id="writer" placeholder="작성자"
						name="writer" value="${loginMember.memberId }"
					>
				</div>

				<button type="submit" class="btn btn-primary" onclick="return isValid()">Submit</button>
				<button type="reset" class="btn btn-secondary">Reset</button>
			</form>
		</div>
	</div>


	<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>