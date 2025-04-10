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
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="container mt-5">
		<div class="row">

			<h1>회원가입</h1>
			<form action="/member/signup" method="POST">
				<div class="mb-3 mt-3">
					<label for="memberId">아이디 : </label><span></span> <input
						type="text" class="form-control" id="memberId"
						placeholder="아이디를 입력하세요..." name="memberId"
					> <input type="hidden" id="idValid" />
				</div>
				<div class="mb-3">
					<label for="memberPwd1">비밀번호 : </label><span></span> <input
						type="password" class="form-control" id="memberPwd1"
						placeholder="비밀번호를 입력하세요..." name="memberPwd"
					>
				</div>
				<div class="mb-3">
					<label for="memberPwd2">비밀번호 확인 : </label> <input type="password"
						class="form-control" id="memberPwd2"
						placeholder="비밀번호를 다시 한번 입력하세요..."
					><input type="hidden" id="pwdValid" />
				</div>
				<div class="mb-3">
					<label for="email">이메일 : </label><span></span> <input type="email"
						class="form-control" id="email" placeholder="이메일을 입력하세요..."
						name="email"
					><input type="hidden" id="emailValid" />
				</div>
				<div class="mb-3">
					<label for="memberName">이름 : </label><span></span> <input
						type="text" class="form-control" id="memberName"
						placeholder="이름을 입력하세요..." name="memberName"
					>
				</div>


				<button type="submit" class="btn btn-success"
					onclick="return isValid()"
				>가입</button>
				<button type="submit" class="btn btn-danger">취소</button>
			</form>

		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>