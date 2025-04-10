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
<script src="${pageContext.request.contextPath}/resources/js/list.js" defer></script>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="container mt-5">
		<div class="row">

			<div>${diaryList }</div>

			<ul class="list-group">
				<c:forEach var="diary" items="${diaryList }">
					<li class="list-group-item">
						<div class="form-check">
							<input class="form-check-input finishedCheckbox" type="checkbox" id="check1" data-dno="${diary.dno }"
								<c:if test="${diary.finished }">checked</c:if>
							><label class="form-check-label" for="check1">${diary.title }</label>
							<span>${diary.dueDate }</span>
						</div>



					</li>
				</c:forEach>
			</ul>

		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>